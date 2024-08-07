import 'package:hive/hive.dart';
part 'blog_model.g.dart';

@HiveType(typeId: 0)
class Blog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String content;

  @HiveField(4)
  bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    this.isFavorite = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      content: json['content'] as String? ?? '',
      isFavorite: false,
    );
  }

  Blog copyWith({bool? isFavorite}) {
    return Blog(
      id: id,
      title: title,
      imageUrl: imageUrl,
      content: content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
