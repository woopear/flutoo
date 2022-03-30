import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserState user = UserState();

  // fonction de connexion user
  Future<void> connexionAuth(
      TextEditingController email, TextEditingController password) async {
    await _auth.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    notifyListeners();
  }

  // fonction création user
  Future<void> createAuth(TextEditingController email,
      TextEditingController password, UserSchema userSchema) async {
    // création du user de firebase
    final usercurrent = await _auth.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    /// creation user data firestore
    userSchema.uid = usercurrent.user!.uid;
    user.addUser(userSchema);
    notifyListeners();
  }

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectAuth() async {
    await _auth.signOut();
    user.resetUser();
    notifyListeners();
  }
}

final authState = ChangeNotifierProvider<AuthState>((ref) => AuthState());
