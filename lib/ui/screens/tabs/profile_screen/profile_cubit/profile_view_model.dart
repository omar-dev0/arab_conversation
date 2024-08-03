import 'package:arab_conversation/data/model/user.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile_cubit/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  AuthRepo authRepo;
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @factoryMethod
  ProfileViewModel(this.authRepo) : super(InitState());

  User get user => authRepo.get();

  void togelScreens() {
    email.text = user.email!;
    List<String> name = user.name!.split(' ');
    if (name.length > 1) {
      firstName.text = name[0];
      lastName.text = name[1];
    }
    emit(EditProfile());
  }

  Future<void> updateUser() async {
    emit(LoadingUpdateProfile());
    try {
      String userName = firstName.text + ' ' + lastName.text;
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
