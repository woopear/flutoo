import 'package:flutoo/models/signup/widgets/signup.dart';

import '../models/signin/widgets/signin.dart';
import '../widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool singinSingup = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarFlutoo(),
        body: Container(
          child: Column(
            children: [
              (singinSingup == true) ? const Signin() : const Singup(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        singinSingup = !singinSingup;
                      })
                    },
                    child: (singinSingup == true)
                        ? const Text("Page d'inscription")
                        : const Text("Page de connexion"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
