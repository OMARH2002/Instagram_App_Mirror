import 'package:instagram_duplicate_app/DATA/Create_user_profile_MODEL.dart';

class CreateuserprofileStates {}

class CreateuserprofileInitialState extends CreateuserprofileStates {}

class CreateuserprofileLoadingState extends CreateuserprofileStates {}

class CreateuserprofileLoadedState extends CreateuserprofileStates {
  final CreateUserProfileModel userProfile;
  CreateuserprofileLoadedState(this.userProfile);
}

class CreateuserprofileSuccesState extends CreateuserprofileStates {}

class CreateuserprofileErrorState extends CreateuserprofileStates {
  final String errorMessage;
  CreateuserprofileErrorState(this.errorMessage);
}

// ✅ Added missing state: Avatar updated successfully
class CreateuserprofileAvatarUpdatedState extends CreateuserprofileStates {
  final String avatarUrl;
  CreateuserprofileAvatarUpdatedState(this.avatarUrl);
}
