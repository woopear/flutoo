import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_constant.dart';
import 'package:flutoo/models/auth/auth_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  /// afficher / cacher mot de passe dans input
  void seePassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  /// connexion utilisateur simple
  Future<void> connexionUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// petit load à la connexion
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        /// connexion auth firebase
        await ref.watch(authState).connexionAuth(email, password);

        /// go to page dashboard
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, Routes().todo);
      } on FirebaseAuthException catch (e) {
        /// email errorné
        if (e.code == 'user-not-found') {
          NotifMessage(
            text: AuthConstant.connexionUserEmailMessageError,
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception(AuthConstant.connexionUserEmailMessageError);
        } else if (e.code == 'wrong-password') {
          /// mot de passe érroné
          NotifMessage(
            text: AuthConstant.connexionUserPasswordError,
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception(AuthConstant.connexionUserPasswordError);
        }
        Navigator.of(context, rootNavigator: true).pop();
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
                  margin: const EdgeInsets.only(top: 70.0),
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
                        margin: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          obscureText: obscureText,
                          controller: password,
                          decoration: const InputDecoration().copyWith(
                              suffixIcon: InkWell(
                                onTap: seePassword,
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              labelText: AuthConstant.labelInputPassword),
                          validator: (value) => Validator.validatePassword(
                            textError: Validator.inputConnexionPassword,
                            value: value,
                          ),
                        ),
                      ),

                      /// btn mot de passe oublié
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0, top: 10.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes().sendResetPassword);
                                },
                                child: Text(
                                  'Mot de passe oublié ?',
                                  style: const TextStyle().copyWith(
                                    color: Colors.blue,
                                  ),
                                ))),
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
