import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/User.dart';

class UserService {
  // inisalisation de l'insatnace FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // fonction auth
  Future<User_model> auth(User_model userModel) async {
    UserCredential userCredential;
    
    userCredential = await _auth.signInWithEmailAndPassword(
        email: userModel.email!, password: userModel.password!);

    userModel.setUid = userCredential.user?.uid;

    return userModel;
  }
}
