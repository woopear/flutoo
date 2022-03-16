import 'package:flutoo/config/routes/routes.dart';
import '../widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutoo/models/User.dart';
import 'package:flutoo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_connexion/woo_widget_connexion.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserService userService = UserService();
  User_model userModel = User_model();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarFlutoo(),
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
                    userModel.email = value['email'];
                    userModel.password = value['password'];
                    userService.auth(userModel);
                  },
                  Container(
          /// bouton pour test TODO : a supprimer
          child: ElevatedButton(
            child: const Text('dashboard'),
            onPressed: () => Navigator.pushNamed(context, Routes().todo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
