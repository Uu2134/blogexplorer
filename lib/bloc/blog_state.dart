import 'package:blogexplorer/models/blog_model.dart';
import 'package:equatable/equatable.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final List<Blog> filteredBlogs;

  const BlogLoaded(this.blogs, [this.filteredBlogs = const []]);

  @override
  List<Object> get props => [blogs, filteredBlogs];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object> get props => [message];
}
