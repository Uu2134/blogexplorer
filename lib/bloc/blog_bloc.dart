import 'package:blogexplorer/models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blog_event.dart';
import 'blog_state.dart';
import 'package:blogexplorer/api_services/api_service.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiService apiService;

  BlogBloc({required this.apiService}) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchBlogs>(_onSearchBlogs);
    print("BlogBloc initialized");
  }
  
  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await apiService.fetchBlogs(); // Await the future
      emit(BlogLoaded(blogs, blogs));
      print("Blogs fetched successfully");
    } catch (e) {
      emit(BlogError('Failed to fetch blogs: $e'));
      print("Error fetching blogs: $e");
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<BlogState> emit) {
    if (state is BlogLoaded) {
      final List<Blog> updatedBlogs = (state as BlogLoaded).blogs.map((blog) {
        return blog.id == event.blog.id
            ? blog.copyWith(isFavorite: !blog.isFavorite)
            : blog;
      }).toList();
      print("Toggled favorite status");
      emit(BlogLoaded(updatedBlogs, updatedBlogs));
    }
    print("Toggle favorite attempted");
  }

  void _onSearchBlogs(SearchBlogs event, Emitter<BlogState> emit) {
    if (state is BlogLoaded) {
      final List<Blog> filteredBlogs = (state as BlogLoaded)
          .blogs
          .where((blog) => blog.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(BlogLoaded((state as BlogLoaded).blogs, filteredBlogs));
    }
  }
}
