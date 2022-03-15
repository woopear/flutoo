import 'package:flutter/material.dart';
import 'package:woo_widget_connexion/woo_widget_connexion.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                InputConnexion(
                  emaillabelText: "Email",
                  pwslabelText: "Mot de passe",
                  emailmargin: const EdgeInsets.all(20),
                  pwsmargin: const EdgeInsets.all(20),
                  resultForm: (value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
