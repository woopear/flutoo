import 'package:flutter/material.dart';

class NotifMessage {
  String? text;
  bool? error;

  NotifMessage({
    Key? key,
    required this.text,
    required this.error,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notification(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text!,
          style: TextStyle(
            color: error! ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
