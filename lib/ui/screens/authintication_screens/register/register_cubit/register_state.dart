sealed class RegisterStates {}

class InitState extends RegisterStates {}

class Loading extends RegisterStates {}

class Error extends RegisterStates {
  String error;

  Error(this.error);
}

class Success extends RegisterStates {}
