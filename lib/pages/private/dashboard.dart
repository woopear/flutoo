import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/condition/widgets/condition_widget.dart';
import 'package:flutoo/models/todo/widgets/todo_widget.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutoo/config/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int indexSelection = 0;

  static const List<Widget> widgetOptions = [
    TodoWidget(),
    Text('coucou'),
    ConditionWidget(),
  ];

  void onItemTapped(int index) {
    setState(() {
      indexSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarFlutoo(),
        body: SingleChildScrollView(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              /// en chargement
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingData();
              }

              /// si error
              if (snapshot.hasError) {
                return const WaitingError();
              }

              /// si uid n'existe pas
              if (snapshot.data?.uid == null) {
                Navigator.pushNamed(context, Routes().home);
              }

              /// recupere le user connecter
              context.read<UserProvider>().streamUsers(snapshot.data!.uid);
              return widgetOptions.elementAt(indexSelection);
            }),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexSelection,
          onTap: onItemTapped,
          items: const [
            /// todo
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              tooltip: 'todo',
              label: '',
            ),

            ///profil
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              tooltip: 'profil',
              label: '',
            ),

            /// TODO : faire condition pour l'affichage seulement pour user admin

            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              tooltip: 'Conditions générales',
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
