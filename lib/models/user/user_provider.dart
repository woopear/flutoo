import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<UserSchema>> users;
  UserSchema? user;

  /// ecouteur user + ecouteur userCurrent
  Future<void> streamUsers(String uid) async {
    users = _firestoreService.streamCol(
        path: FirestorePath.usersCollection(),
        builder: (data, documentId) => UserSchema.formMap(data, documentId),
        queryBuilder: (query) => query.where('uid', isEqualTo: uid));

    users.listen((event) {
      user = event[0];
      notifyListeners();
    });
  }

  /// création du user de la base de donnée
  Future<void> addUser(UserSchema userSchema) async {
    await _firestoreService.add(
      path: FirestorePath.usersCollection(),
      data: userSchema.toMap(),
    );
    notifyListeners();
  }

  /// mofification d'un user
  Future<void> updateUser(String idUser, UserSchema data) async =>
      await _firestoreService.update(
        path: FirestorePath.userCollection(idUser),
        data: data.toMap(),
      );

  
}
