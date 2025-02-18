class UserPageStates{}

class UserPageInitialState extends UserPageStates{}
class UserPageLoadingState extends UserPageStates{}
class UserPageSuccessState extends UserPageStates{
  final String name; // ✅ Ensure name exists
  UserPageSuccessState(this.name);
}
class UserPageErrorState extends UserPageStates{

  final String errorMessage;
  UserPageErrorState(this.errorMessage);
}