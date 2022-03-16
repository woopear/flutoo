import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // inisalisation de l'insatnace FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // fonction auth
  Future<User_model> auth(User_model userModel) async {
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

    return userModel;
  }
}
