class CreateuserprofileStates{}

class CreateuserprofileInitialState extends CreateuserprofileStates{}

class CreateuserprofileLoadingState extends CreateuserprofileStates{}

class CreateuserprofileSuccesState extends CreateuserprofileStates{}

class CreateuserprofileErrorState extends CreateuserprofileStates{

  final  String errorMessage;
  CreateuserprofileErrorState(this.errorMessage);

}

