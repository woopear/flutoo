import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // inisalisation de l'insatnace FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService.instance;
  CollectionReference userApi = FirebaseFirestore.instance.collection('users');
  late Stream<List<UserSchema>> users;
  UserSchema? user;

  bool get uu => user != null;

  /// ecouteur user + ecouteur userCurrent
  Future<void> streamUsers(String uid) async {
    users = _firestoreService.streamCol(
      path: FirestorePath.usersCollection(),
      builder: (data, documentId) => UserSchema.formMap(data, documentId),
      queryBuilder: (query) => query.where('uid', isEqualTo: uid),
    );

    users.listen((event) {
      user = event[0];
      notifyListeners();
    });
  }

  // création du user de la base de donnée
  Future<void> addUser(UserSchema userSchema) async {
    await userApi.add(userSchema.toMap());
    notifyListeners();
  }
}
