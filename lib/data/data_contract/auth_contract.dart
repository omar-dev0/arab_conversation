import 'package:arab_conversation/data/model/user.dart' as userApp;
import 'package:dartz/dartz.dart';

abstract class AuthSystem {
  Future<String?> registration(userApp.User user, String password);

  Future<Either<String, userApp.User?>> login(String email, String password);

  Future<Either<String, userApp.User?>> loginWithGoogle();

  Future<String?> resetPassword(String email);

  Future<userApp.User?> isSigneIn();

  Future<void> signOut();

  Future<void> updateUser(String id, Map<String, dynamic> updatedUser);
}
