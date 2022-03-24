import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_constant.dart';
import 'package:flutoo/models/auth/auth_provider.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  /// inscription user
  Future<void> inscritionAuth(BuildContext context, String uid) async {
    if (_formKey.currentState!.validate()) {
      // inscription user firebase
      try {
        /// creation auth
        await context
            .read<AuthProvider>()
            .createAuth(email.text.trim(), password.text.trim());

        /// variable userShema
        UserSchema userSchema = UserSchema(
          uid: uid,
          email: email.text.trim(),
          pseudo: pseudo.text,
          firstName: firstName.text,
          lastName: lastName.text,
        );

        /// ajouter un user bdd
        await context.read<UserProvider>().addUser(userSchema);

        /// navigé vers la todo
        Navigator.pushNamed(context, Routes().todo);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          NotifMessage(
            text: AuthConstant.inscriptionUserPasswordError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.inscriptionUserPasswordError);
        } else if (e.code == 'email-already-in-use') {
          NotifMessage(
            text: AuthConstant.inscriptionUserEmailError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.inscriptionUserEmailError);
        }
      }

      // ajouter un User dans notre bdd

      // rest le form
      _formKey.currentState!.reset();
      email.clear();
      password.clear();

      // norification succés
      NotifMessage(
        text: AuthConstant.inscriptionUserMessageSucces,
        error: true,
      ).notification(context);
    } else {
      // norification d'erreur
      NotifMessage(
        text: AuthConstant.inscriptionError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // récuperation du current user
    final auth = context.watch<AuthProvider>().authenticate;

    return Container(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Votre Email',
                    ),
                    validator: (value) => Validator.validateEmail(
                      textError: Validator.inputConnexionEmail,
                      value: value,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      labelText: 'Votre mot de passe',
                    ),
                    validator: (value) => Validator.validatePassword(
                      textError: Validator.inputConnexionPassword,
                      value: value,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: pseudo,
                    decoration: const InputDecoration(
                      labelText: 'Votre pseudo',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: lastName,
                    decoration: const InputDecoration(
                      labelText: 'Votre prénom',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: firstName,
                    decoration: const InputDecoration(
                      labelText: 'Votre Nom',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await inscritionAuth(context, auth!.uid);
                  },
                  child: const Text("S'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
