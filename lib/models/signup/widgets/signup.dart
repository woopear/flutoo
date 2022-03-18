import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserProvider userProvider = UserProvider();
  UserModel userModel = UserModel();
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                InputCustom(
                  labelText: 'Email',
                  onChange: (value) {
                    setState(() {
                      userModel.email = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputCustom(
                  labelText: 'Nom',
                  onChange: (value) {
                    setState(() {
                      userModel.firstName = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputCustom(
                  labelText: 'Prenom',
                  onChange: (value) {
                    setState(() {
                      userModel.lastName = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputCustom(
                  labelText: 'Pseudo',
                  onChange: (value) {
                    setState(() {
                      userModel.pseudo = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputCustom(
                  labelText: 'Mot de passe',
                  onChange: (value) {
                    setState(() {
                      userModel.password = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userProvider.createUser(userModel);

                      FirebaseAuth.instance.authStateChanges().listen(
                      (currentUser) {
                      if (currentUser != null) {
                        Navigator.pushNamed(context, Routes().todo);
                      }
                    },
                  );
                    }
                  },
                  child: const Text('Valider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
