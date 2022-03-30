import 'package:flutoo/models/mail_reset_password/widgets/mail_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendResetPassword extends ConsumerStatefulWidget {
  const SendResetPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendResetPasswordState();
}

class _SendResetPasswordState extends ConsumerState<SendResetPassword> {
  @override
  Widget build(BuildContext context) {
    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mot de passe oublié'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: widthTodo > 700 ? 700.0 : double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: const MailResetPassword(),
            ),
          ),
        ),
      ),
    );
  }
}
