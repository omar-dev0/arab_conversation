import 'package:arab_conversation/data/model/user.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/register/register_cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class RegisterViewModel extends Cubit<RegisterStates> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  IconData passwordEye = Icons.visibility;
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthRepo repo;

  @factoryMethod
  RegisterViewModel(this.repo) : super(InitState());

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
    if (password.length < 8) {
      return 'your password less than 8 characters';
    }
    return null;
  }

  String? validName(String? name) {
    if (name!.isEmpty) {
      return 'please enter name';
    }
    return null;
  }

  String? validConfirmPassword(String? rePassword) {
    if (rePassword!.isEmpty) {
      return 'please re enter password';
    } else if (password.text != confirmPassword.text) {
      return 'not match password';
    }

    return null;
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(Loading());

      String? result = await repo.registration(
          User(name: name.text, email: email.text), password.text);
      if (result != null) {
        emit(Error(result));
      } else {
        emit(Success());
      }
    }
  }
}
