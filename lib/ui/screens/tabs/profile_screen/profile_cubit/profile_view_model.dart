import 'package:arab_conversation/data/model/user.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final AuthRepo authRepo;
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  @factoryMethod
  ProfileViewModel(this.authRepo) : super(InitState());

  User get user => authRepo.get();

  void togelScreens() {
    final List<String> name = user.name!.split(' ');
    if (name.length > 1) {
      firstName.text = name[0];
      lastName.text = name[1];
      email.text = user.email!;
      emit(EditProfile());
    } else {
      firstName.text = name[0];
      lastName.text = '';
      email.text = user.email!;
      emit(EditProfile());
    }
  }

  Future<void> updateUser() async {
    emit(LoadingUpdateProfile());
    try {
      final String userName = '${firstName.text} ${lastName.text}';
      await authRepo.updateUser(user.id!, {'name': userName});
      user.name = userName;
      emit(SuccessUpdateProfile('update user successfully'));
    } catch (e) {
      emit(ErrorUpdateProfile('can\'t update profile someThing went wrong'));
    }
  }

  void backToProfile() {
    emit(InitState());
  }

  void signOut() async {
    await authRepo.signOut();
    emit(SignOut());
  }
}
