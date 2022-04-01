import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MailResetPassword extends ConsumerStatefulWidget {
  const MailResetPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MailResetPasswordState();
}

class _MailResetPasswordState extends ConsumerState<MailResetPassword> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

/// envoie de l'email de réinitialisation mot de passe
  Future<void> sendEmailChangePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        /// envoie email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'auth/invalid-email') {
          NotifMessage(
            text: 'Email non valide',
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception('Email non valide');
        } else if (e.code == 'auth/user-not-found') {
          NotifMessage(
            text: 'Utilisateur non connu',
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception('Utilisateur non connu');
        } else {
          /// message d'erreur
          NotifMessage(
            text: "Email inconnu",
            error: true,
          ).notification(context);
          throw Exception('Email inconnu');
        }
      }

      /// reset form
      _formKey.currentState!.reset();
      email.clear();

      /// message envoie réussis
      NotifMessage(
        text: "Email envoyé",
        error: false,
      ).notification(context);

      /// go to page home
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushNamed(context, Routes().home);
    } else {
      /// message d'erreur
      NotifMessage(
        text: "Impossible d'envoyer l'email",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// title page
            Container(
              child: const Text(
                'Demande de changement de mot de passe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26.0),
              ),
            ),

            /// subtitle explication de la modification de password
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 50.0),
              child: const Text(
                'Attention vous êtes sur le point de modifier votre mot de passe,\n entrer votre email ci-dessous puis valider. Vous recevrez un email avec la procèdure à suivre',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ),

            /// input email
            Container(
              child: TextFormField(
                controller: email,
                decoration:
                    const InputDecoration().copyWith(labelText: 'Email'),
                validator: (value) => Validator.validateEmail(
                  textError: Validator.inputConnexionEmail,
                  value: value,
                ),
              ),
            ),

            /// groupe de btn
            Row(
              children: [
                Expanded(child: Container()),

                /// btn retour home
                Container(
                  margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes().home);
                    },
                    child: const Text('Anuller'),
                  ),
                ),

                /// btn reset password
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await sendEmailChangePassword();
                    },
                    child: const Text('Envoyer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
