class UserPageStates{}

class UserPageInitialState extends UserPageStates{}
class UserPageLoadingState extends UserPageStates{}
class UserPageSuccessState extends UserPageStates {
  final String name;
  final String username;
  final String website;
  final String bio;
  final String category;
  final String avatar;

  // Constructor to accept all fields
  UserPageSuccessState({
    required this.name,
    required this.username,
    required this.website,
    required this.bio,
    required this.category,
    required this.avatar,

  });
}
class UserPageErrorState extends UserPageStates{

  final String errorMessage;
  UserPageErrorState(this.errorMessage);
}