import 'package:flutoo/pages/home.dart';
import 'package:flutter/material.dart';

class Routes {
  String home = '/';
  String todo = '/todo';

  Map<String, Widget Function(BuildContext)> urls() {
    return {
      '/': (context) => const Home(),
    };
  }
}
