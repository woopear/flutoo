import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/condition/widgets/condition_widget.dart';
import 'package:flutoo/models/todo/widgets/todo_widget.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int indexSelection = 0;

  /// list des widget relier à la bottomnavbar
  static const List<Widget> widgetOptions = [
    TodoWidget(),
    Text('coucou'),
    ConditionWidget(),
  ];

  /// selection de l'index pour le bottomnavbar
  void onItemTapped(int index) {
    setState(() {
      indexSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere les users pour tester
    /// le role afin d'affiche ou pas la partie condition gen
    final user = context.watch<UserProvider>().user;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const AppBarFlutoo(),
        body: SingleChildScrollView(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              /// si on les données
              if (snapshot.hasData) {
                /// recupere le user connecter
                return widgetOptions.elementAt(indexSelection);
              }

              if(snapshot.connectionState == ConnectionState.done){
                  context.read<UserProvider>().streamUsers(snapshot.data!.uid);
              }

              /// en chargement
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingData();
              }

              /// si pas de data et chargement terminé
              /// on affiche une erreur
              return const WaitingError();
            }),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexSelection,
          onTap: onItemTapped,
          items: const [
            /// list des todos
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
