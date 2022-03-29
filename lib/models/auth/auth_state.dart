import 'package:firebase_auth/firebase_auth.dart';
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
  Future<UserCredential> createAuth(
      TextEditingController email, TextEditingController password) async {
    // création du user de firebase
    final user = _auth.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    notifyListeners();
    return user;
  }

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectAuth() async {
    await _auth.signOut();

    user.resetUser();
    notifyListeners();
  }
}

final authState = ChangeNotifierProvider<AuthState>((ref) => AuthState());
