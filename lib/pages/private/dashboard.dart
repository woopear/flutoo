import 'package:flutoo/models/condition/widgets/condition_widget.dart';
import 'package:flutoo/models/todo/widgets/todo_widget.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';

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
          child: widgetOptions.elementAt(indexSelection),
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
