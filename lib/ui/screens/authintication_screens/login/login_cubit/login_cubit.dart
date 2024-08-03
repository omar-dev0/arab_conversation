import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class LoginViewModel extends Cubit<LoginStates> {
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IconData passwordEye = Icons.visibility;
  bool showPassword = false;
  AuthRepo repo;

  @factoryMethod
  LoginViewModel(this.repo) : super(InitState());

  void changeVisibility() {
    showPassword = !showPassword;
    if (showPassword == false) {
      passwordEye = Icons.visibility;
    } else {
      passwordEye = Icons.visibility_off;
    }
    emit(InitState());
  }

  String? validEmail(String? email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!);
    if (email.isEmpty) {
      return 'please enter your Email';
    }
    if (emailValid) {
      return null;
    }
    return 'please enter valid Email';
  }

  String? validPassword(String? password) {
    if (password!.isEmpty) {
      return 'please enter password';
    }
    return null;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(Loading());
      String? error = await repo.login(email!.text, password!.text);
      if (error != null) {
        if (error == 'you need to verify your email') {
          emit(Error('you need to verify your email'));
        } else {
          emit(Error('your password or email not correct'));
        }
      } else {
        emit(Success());
      }
    }
  }
}


