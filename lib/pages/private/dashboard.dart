import 'package:flutoo/models/profil/widgets/profil_user.dart';
import 'package:flutoo/models/todo/widgets/todo_widget.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int indexSelection = 0;
  bool test = false;

  /// list des widget relier à la bottomnavbar
  static const List<Widget> widgetOptions = [
    TodoWidget(),
    ProfilUser(),
    //ConditionWidget(),
  ];

  /// selection de l'index pour le bottomnavbar
  void onItemTapped(int index) {
    setState(() {
      indexSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCurrent);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const AppBarFlutoo(),
        body: SingleChildScrollView(
          child: widgetOptions.elementAt(indexSelection),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexSelection,
          onTap: onItemTapped,
          items: [
            /// list des todos
            const BottomNavigationBarItem(
              icon: Icon(Icons.list),
              tooltip: 'todo',
              label: '',
            ),

            ///profil
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              tooltip: 'profil',
              label: '',
            ),

            /// condition
            /// si pas user root pas de menu
            if (user?.role!['libelle'] == 'root')
              const BottomNavigationBarItem(
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
