sealed class ForgetPasswordState {}

class Error extends ForgetPasswordState {
  String error;

  Error(this.error);
}

class InitState extends ForgetPasswordState {}

class Success extends ForgetPasswordState {}

class Loading extends ForgetPasswordState {}
