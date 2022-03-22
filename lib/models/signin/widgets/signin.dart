import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_connexion/woo_widget_connexion.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  UserProvider userProvider = UserProvider();
  UserSchema userSchema = UserSchema(email: '', password: '', uid: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              InputConnexion(
                emaillabelText: "Email",
                pwslabelText: "Mot de passe",
                emailmargin: const EdgeInsets.all(20),
                pwsmargin: const EdgeInsets.all(20),
                resultForm: (value) {
                  userSchema.email = value['email'];
                  userSchema.password = value['password'];
                  userProvider.auth(userSchema);
                  FirebaseAuth.instance.authStateChanges().listen(
                    (currentUser) {
                      if (currentUser != null) {
                        userProvider.streamUsers(currentUser.uid);
                        Navigator.pushNamed(context, Routes().todo);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}