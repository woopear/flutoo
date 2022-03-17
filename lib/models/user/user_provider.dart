import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // inisalisation de l'insatnace FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userApi = FirebaseFirestore.instance.collection('users');

  // fonction auth
  Future<UserModel> auth(UserModel userModel) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);

      userModel.setUid = userCredential.user?.uid;

      User? currentUser = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('ce n est pas le bonne email.');
      } else if (e.code == 'wrong-password') {
        print('le mot de passe est mauvais.');
      }
    }
    notifyListeners();
    
    return userModel;
  }

  // fonction qui écoute

  // fonction qui déconnecte le userCurrent

  // function create user
  Future<void> createUser(UserModel userModel) async {
    UserCredential userCredential;

    try {
      // création du user de firebase
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email!, password: userModel.password!);

      userModel.setUid = userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    addUser(userModel);
    notifyListeners();
  }

  Map<String, dynamic> createMapUser(UserModel userModel) {
    return {
      'email': userModel.email,
      'uid': userModel.uid,
      'firstName': userModel.firstName,
      'lastName': userModel.lastName,
      'pseudo': userModel.pseudo,
      'termes': false,
    };
  }

  // création du user de la base de donnée
  Future<void> addUser(UserModel userModel) async {
    await userApi.add(createMapUser(userModel));
  }
}
