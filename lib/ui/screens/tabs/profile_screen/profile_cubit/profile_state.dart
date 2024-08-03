sealed class ProfileState {}

class InitState extends ProfileState {}

class EditProfile extends ProfileState {}

class LoadingUpdateProfile extends ProfileState {}

class ErrorUpdateProfile extends ProfileState {
  String error;

  ErrorUpdateProfile(this.error);
}

class SuccessUpdateProfile extends ProfileState {
  String text;

  SuccessUpdateProfile(this.text);
}

class SignOut extends ProfileState {}
