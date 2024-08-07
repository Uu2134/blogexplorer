import 'package:blogexplorer/bloglist_screen.dart';
import 'package:blogexplorer/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/blog_bloc.dart';
import 'bloc/blog_event.dart';
import 'api_services/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox<Blog>('blogs');
  runApp(BlogExplorerApp());
}

class BlogExplorerApp extends StatelessWidget {
  const BlogExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      home: BlocProvider(
        create: (context) => BlogBloc(apiService: ApiService())..add(FetchBlogs()),
        child: const BlogListScreen(),
      ),
    );
  }
}
