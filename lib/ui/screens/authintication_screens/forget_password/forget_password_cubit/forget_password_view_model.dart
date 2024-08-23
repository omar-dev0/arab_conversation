import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/forget_password/forget_password_cubit/forget_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthRepo repo;

  @factoryMethod
  ForgetPasswordViewModel(this.repo) : super(InitState());

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

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(Loading());
      final String? error = await repo.resetPassword(email.text);
      if (error != null) {
        emit(Error(error));
      } else {
        emit(Success());
      }
    }
  }
}
