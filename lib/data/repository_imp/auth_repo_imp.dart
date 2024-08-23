import 'package:arab_conversation/data/data_contract/auth_contract.dart';
import 'package:arab_conversation/data/model/user.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepo)
@Injectable(as: AuthRepo)
class AuthRepoImp extends AuthRepo {
  final AuthSystem authSystem;
   User? user;

  @factoryMethod
  AuthRepoImp(this.authSystem);

  @override
  Future<String?> login(String email, String password) async {
    Either<String, User?> result = await (authSystem.login(email, password));
    if (result.isRight()) {
      user = result.fold((l) => null, (r) => r);
    } else {
      return result.fold((l) => l, (r) => null);
    }
    return null;
  }

  @override
  Future<String?> registration(User user, String password) async {
    return authSystem.registration(user, password);
  }

  @override
  User get() => user ?? User(name: '', email: '');

  @override
  Future<String?> resetPassword(String email) async {
    return await authSystem.resetPassword(email);
  }

  @override
  Future<bool> isSigneIn() async {
    user = await authSystem.isSigneIn();
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await authSystem.signOut();
    user = null;
  }

  @override
  Future<void> updateUser(String id, Map<String, dynamic> updatedUser) async {
    user?.name = updatedUser['name'];
    await authSystem.updateUser(id, updatedUser);
    return;
  }

  @override
  Future<String?> loginWithGoogle()async{
    Either<String? , User?> result = await (authSystem.loginWithGoogle());
    if(result.isRight())
      {
        user = result.fold((l) => null, (r) => r);
      }
    else
      {
        return result.fold((l) => l, (r) => null);
      }
    return null;

  }
}
