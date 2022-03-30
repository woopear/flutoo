import 'package:flutoo/pages/condition.dart';
import 'package:flutoo/pages/home.dart';
import 'package:flutoo/pages/private/dashboard.dart';
import 'package:flutter/material.dart';

class Routes {
  String home = '/';
  String todo = '/dashboard';
  String conditions = '/conditions';

  Map<String, Widget Function(BuildContext)> urls() {
    return {
      '/': (context) => const Home(),
      '/dashboard': (context) => const Dashboard(),
      '/conditions': (context) => const Condition(),
    };
  }
}
