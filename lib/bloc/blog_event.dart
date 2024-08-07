import 'package:blogexplorer/models/blog_model.dart';
import 'package:equatable/equatable.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class ToggleFavorite extends BlogEvent {
  final Blog blog;

  const ToggleFavorite(this.blog);

  @override
  List<Object> get props => [blog];
}

class SearchBlogs extends BlogEvent {
  final String query;

  const SearchBlogs(this.query);

  @override
  List<Object> get props => [query];
}
