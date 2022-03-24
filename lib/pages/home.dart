import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/auth/auth_provider.dart';
import 'package:flutoo/models/auth/widgets/auth_widget.dart';
import 'package:flutoo/pages/private/dashboard.dart';
import 'package:provider/provider.dart';

import '../widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    /// ecouteur pour le changement d'etat du auth
    context.read<AuthProvider>().connexionStateChange();
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarFlutoo(),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /// connexion obligatoire
              return const Dashboard();
            } else {
              /// page de connexion / inscription
              return const AuthWidget();
            }
          },
        ),
      ),
    );
  }
}
