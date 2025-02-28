import 'package:instagram_duplicate_app/DATA/Search_Model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResults extends SearchState {
  final List<User> users;
  SearchResults(this.users);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}