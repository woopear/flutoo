import 'package:flutoo/models/auth/widgets/signin/signin.dart';
import 'package:flutoo/models/auth/widgets/signup/signup.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  bool singinSingup = true;

  /// affiche connexion ou inscription
  void changePage() {
    setState(() {
      singinSingup = !singinSingup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          /// formulaire de connexion ou de creation
          singinSingup == true ? const Signin() : const Singup(),
                
          /// btn connexion ou inscription
          Flex(
            direction: Axis.vertical,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: changePage,
                    child: (singinSingup == true)
                        ? const Text("Céer mon compte")
                        : const Text("Retour"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
