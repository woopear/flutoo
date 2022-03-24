import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? authenticate;

  /// ecouteur de la connexion user
  Future<void> connexionStateChange() async {
    _auth.authStateChanges().listen((User? event) {
      /// on met le currentUser dans authenticate
      authenticate = event;
      notifyListeners();
    });
  }

  // fonction de connexion user
  

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectUserCurrent() async {
    await _auth.signOut();
    notifyListeners();
  }
}
