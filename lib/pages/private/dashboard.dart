import 'package:flutoo/models/todo/widgets/todo_create.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarFlutoo(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                TodoCreate(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              tooltip: 'todo',
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              tooltip: 'profil',
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
