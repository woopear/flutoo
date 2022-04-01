import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/utils/services/fireauth/fireauth_service.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<UserSchema>> _users;
  UserSchema? _user;
  final _firebaseStorage = FirebaseStorage.instance;

  Stream<List<UserSchema>> get users => _users;
  UserSchema? get user => _user;

  /// ecouteur user + ecouteur userCurrent
  Future<void> streamUsers(String uid) async {
    _users = _firestoreService.streamCol(
        path: FirestorePath.usersCollection(),
        builder: (data, documentId) => UserSchema.formMap(data, documentId),
        queryBuilder: (query) => query.where('uid', isEqualTo: uid));
  }

  /// recupere depuis l'arugment
  /// le user current et l'affecte à _user
  Future<void> getUserCurrent(UserSchema user) async {
    _user = user;
  }

  // création du user de la base de donnée
  Future<bool> addUser(UserSchema userSchema) async {
    await _firestoreService.add(
      path: FirestorePath.usersCollection(),
      data: userSchema.toMap(),
    );

    return true;
  }

  /// reset user
  void resetUser() {
    _user = null;
    notifyListeners();
  }

  /// mofification d'un user
  Future<void> updateUser(String idUser, UserSchema data) async =>
      await _firestoreService.update(
        path: FirestorePath.userCollection(idUser),
        data: data.toMap(),
      );

  /// delete les todos du user par son uid
  Future<void> deleteTodoByUid(String uid) async {
    /// instance firestore
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref path
    CollectionReference contents = FirebaseFirestore.instance.collection(
      FirestorePath.todos(),
    );

    return contents.where('uid', isEqualTo: uid).get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        batch.delete(document.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }

  /// delete un user
  Future<void> delete(String idUser, String avatar, String uid) async {
    /// suppression image du user
    _firebaseStorage.refFromURL(avatar).delete();

    /// suppression des todos du user
    deleteTodoByUid(uid);

    /// suppresion du user
    await _firestoreService.delete(
      path: FirestorePath.userCollection(
        idUser,
      ),
    );
  }
}

/// state de la class UserState
final userState = ChangeNotifierProvider<UserState>((ref) => UserState());

/// state de tous les users
/// qui on le uid du user connecter
final allUsers = StreamProvider((ref) {
  ref.watch(auth).whenData((value) {
    ref.watch(userState).streamUsers(value!.uid);
  });
  return ref.watch(userState).users;
});

/// state du user connecter
final userCurrent = Provider<UserSchema?>((ref) {
  ref.watch(allUsers).whenData((value) {
    ref.watch(userState).getUserCurrent(value[0]);
  });
  return ref.watch(userState).user;
});
