sealed class LoginStates {}

class InitState extends LoginStates {}

class Loading extends LoginStates {}

class Success extends LoginStates {}

class Error extends LoginStates {
  final String error;

  Error(this.error);
}
