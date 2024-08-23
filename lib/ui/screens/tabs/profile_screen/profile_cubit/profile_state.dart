sealed class ProfileState {}

class InitState extends ProfileState {}

class EditProfile extends ProfileState {

  EditProfile();
}

class LoadingUpdateProfile extends ProfileState {}

class ErrorUpdateProfile extends ProfileState {
  final String error;

  ErrorUpdateProfile(this.error);
}

class SuccessUpdateProfile extends ProfileState {
final String text;
  SuccessUpdateProfile(this.text);
}
class SignOut extends ProfileState {}
