import 'dart:async';

import 'package:arab_conversation/data/dao/user_dao.dart';
import 'package:arab_conversation/data/data_contract/auth_contract.dart';
import 'package:arab_conversation/data/model/user.dart' as userApp;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthSystem)
class AuthSystemImp extends AuthSystem {
  final UserDao userDao;
    UserCredential? fireUser;

  @factoryMethod
  AuthSystemImp(this.userDao);

  @override
  Future<String?> registration(userApp.User user, String password) async {
    try {
      fireUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      user.id = fireUser?.user?.uid;
      fireUser?.user?.sendEmailVerification();
      await userDao.addUser(user);
    } on FirebaseException catch (e) {
      return e.code;
    }
    return null;
  }

  @override
  Future<Either<String, userApp.User?>> login(
      String email, String password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user.user!.emailVerified) {
        userApp.User? appUser = await userDao.getUser(user.user?.uid);
        return Right(appUser);
      } else {
        return const Left('you need to verify your email');
      }
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      return e.code;
    }
    return null;
  }

  @override
  Future<userApp.User?> isSigneIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return userDao.getUser(FirebaseAuth.instance.currentUser!.uid);
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    fireUser = null;
  }

  @override
  Future<void> updateUser(String id, Map<String, dynamic> updatedUser) async {
    await userDao.updateUser(id, updatedUser);
    return;
  }

  @override
  Future<Either<String, userApp.User?>> loginWithGoogle()async{
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    if(user == null)
      {
        return const Left('Some thing went wrong try again');
      }
    final GoogleSignInAuthentication googleAuth = await user.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    fireUser = userCredential;
    userApp.User appUser = userApp.User(
        name: fireUser?.user?.displayName,
        email: fireUser?.user?.email,
        id: fireUser?.user?.uid
    );
    await userDao.addUser(appUser);
    return  Right(appUser);

  }
}
