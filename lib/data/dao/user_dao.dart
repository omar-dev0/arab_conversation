import 'package:arab_conversation/data/model/user.dart' as appUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class UserDao {
  final db = FirebaseFirestore.instance;
  CollectionReference<appUser.User> get collection =>
      db.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              appUser.User.fromFireStore(snapshot.data()),
          toFirestore: (userOpject, options) => userOpject.toFirebase());

  Future<void> addUser(appUser.User user) async {
    final userCollection = collection;
    await userCollection.doc(user.id).set(user);
  }

  Future<appUser.User?> getUser(String? id) async {
    final snapShot = collection.doc(id);
    final data = await snapShot.get();
    return data.data();
  }

  Future<void> updateUser(String id, Map<String, dynamic> updatedUser) async {
    await collection.doc(id).update(updatedUser);
    return;
  }
}
