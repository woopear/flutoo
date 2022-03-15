
import 'package:flutter/material.dart';
import '../widget_shared/app_bar_flutoo/app_bar_flutoo.dart';

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
        appBar: const AppBarFlutoo(),
        body: Container(),
      ),
    );
  }
}
