import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // inisalisation de l'insatnace FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService.instance;
  CollectionReference userApi = FirebaseFirestore.instance.collection('users');
  late Stream<List<UserSchema>> users;

  // fonction auth
  Future<UserSchema> auth(UserSchema userSchema) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: userSchema.email!, password: userSchema.password!);

      userSchema.uid = userCredential.user?.uid;

      User? currentUser = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('ce n est pas le bonne email.');
      } else if (e.code == 'wrong-password') {
        print('le mot de passe est mauvais.');
      }
    }
    notifyListeners();

    return userSchema;
  }

  // fonction qui écoute le user
  Future<void> streamUsers(String uid) async {
    users = _firestoreService.streamCol(
      path: FirestorePath.usersCollection(),
      builder: (data, documentId) => UserSchema.formMap(data, documentId),
      queryBuilder: (query) => query.where('uid', isEqualTo: uid),
    );
  }

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectUserCurrent() async {
    await FirebaseAuth.instance.signOut();
  }

  // function create user
  Future<void> createUser(UserSchema userSchema) async {
    UserCredential userCredential;

    try {
      // création du user de firebase
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userSchema.email!, password: userSchema.password!);

      userSchema.uid = userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    addUser(userSchema);
    notifyListeners();
  }

  Map<String, dynamic> createMapUser(UserSchema userSchema) {
    return {
      'email': userSchema.email,
      'uid': userSchema.uid,
      'firstName': userSchema.firstName,
      'lastName': userSchema.lastName,
      'pseudo': userSchema.pseudo,
      'termes': false,
    };
  }

  // création du user de la base de donnée
  Future<void> addUser(UserSchema userSchema) async {
    await userApi.add(createMapUser(userSchema));
    notifyListeners();
  }

  // fonction pour lire un user par son uid

}
