 import 'package:instagram_duplicate_app/DATA/Post_Model.dart';
import 'package:instagram_duplicate_app/DATA/story_Model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Post> posts;
  final List<Story> stories;

  HomeLoaded(this.posts, this.stories);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}