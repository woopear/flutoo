import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireAuthSate extends ChangeNotifier {
  late Stream<User?> _auth;

  Stream<User?> get auth => _auth;

  Stream<void>? lisenChangeAuth() {
    _auth = FirebaseAuth.instance.authStateChanges();
    return null;
  }
}

/// state de la class FireAuthState
final fireAuthState =
    ChangeNotifierProvider<FireAuthSate>((ref) => FireAuthSate());

/// state du currentUser
final auth = StreamProvider((ref) {
  ref.watch(fireAuthState).lisenChangeAuth();
  return ref.watch(fireAuthState).auth;
});
