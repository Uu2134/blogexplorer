import 'package:blogexplorer/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class ApiService {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6'; // Provided secret

  Future<List<Blog>> fetchBlogs() async {
    try {
      print("Using admin secret: $adminSecret"); // Debugging

      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      print("API Response Status Code: ${response.statusCode}");
      print("API Response Body: ${response.body}"); // More detailed print

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> blogsJson = jsonResponse['blogs'];
        final blogs = blogsJson.map((json) => Blog.fromJson(json)).toList();

        // Save blogs to Hive
        final box = Hive.box<Blog>('blogs');
        await box.clear();
        await box.addAll(blogs);

        return blogs;
      } else {
        throw Exception('Failed to load blogs: ${response.statusCode}');
      }
    } catch (e) {
      print("Error in fetchBlogs: $e");

      // If there is an error, load blogs from Hive
      final box = Hive.box<Blog>('blogs');
      return box.values.toList();
    }
  }
}
