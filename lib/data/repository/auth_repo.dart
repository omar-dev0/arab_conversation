import 'package:arab_conversation/data/model/user.dart';

abstract class AuthRepo {
  Future<String?> registration(User user, String password);

  Future<String?> login(String email, String password);

  Future<String?> resetPassword(String email);

  Future<bool> isSigneIn();

Future<String?> loginWithGoogle();

  Future<void> signOut();

  User get();

  Future<void> updateUser(String id, Map<String, dynamic> updatedUser);
}
