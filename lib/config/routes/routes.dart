import 'package:flutoo/pages/condition.dart';
import 'package:flutoo/pages/home.dart';
import 'package:flutoo/pages/private/dashboard.dart';
import 'package:flutoo/pages/reset_password.dart';
import 'package:flutoo/pages/send_reset_password.dart';
import 'package:flutter/material.dart';

class Routes {
  String home = '/';
  String todo = '/dashboard';
  String conditions = '/conditions';
  String resetPassword = '/reset-password';
  String sendResetPassword = '/send-reset-password';

  Map<String, Widget Function(BuildContext)> urls() {
    return {
      '/': (context) => const Home(),
      '/dashboard': (context) => const Dashboard(),
      '/conditions': (context) => const Condition(),
      '/reset-password': (context) => const ResetPassword(),
      '/send-reset-password': (context) => const SendResetPassword(),
    };
  }
}
