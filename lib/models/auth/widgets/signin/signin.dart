import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_constant.dart';
import 'package:flutoo/models/auth/auth_provider.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  /// connexion utilisateur simple
  Future<void> connexionUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// connexion auth firebase
        await context
            .read<AuthProvider>()
            .connexionAuth(email.text.trim(), password.text.trim());

        /// go to page dashboard
        Navigator.pushNamed(context, Routes().todo);
      } on FirebaseAuthException catch (e) {
        /// email errorné
        if (e.code == 'user-not-found') {
          NotifMessage(
            text: AuthConstant.connexionUserEmailMessageError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.connexionUserEmailMessageError);
        } else if (e.code == 'wrong-password') {
          /// mot de passe érroné
          NotifMessage(
            text: AuthConstant.connexionUserPasswordError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.connexionUserPasswordError);
        }
      }

      /// reset form
      _formKey.currentState!.reset();
      email.clear();
      password.clear();

      /// message de confirmation
      NotifMessage(
        text: AuthConstant.connexionSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: AuthConstant.connexionError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le current user
    final auth = context.watch<AuthProvider>().authenticate;

    return Container(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              /// formulaire de connexion
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      /// title de la page
                      Text(
                        AuthConstant.titlePageConnexion,
                        style: const TextStyle(fontSize: 36.0),
                      ),

                      /// input email
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration().copyWith(
                              labelText: AuthConstant.labelInputEmail),
                          validator: (value) => Validator.validateEmail(
                            textError: Validator.inputConnexionEmail,
                            value: value,
                          ),
                        ),
                      ),

                      /// input password
                      Container(
                        margin: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                        child: TextFormField(
                          controller: password,
                          decoration: const InputDecoration().copyWith(
                              labelText: AuthConstant.labelInputPassword),
                          validator: (value) => Validator.validatePassword(
                            textError: Validator.inputConnexionPassword,
                            value: value,
                          ),
                        ),
                      ),

                      /// btn connexion
                      ElevatedButton(
                        onPressed: () async {
                          /// on connect le user
                          await connexionUser(context);
                        },
                        child: Text(AuthConstant.btnConnexion),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
