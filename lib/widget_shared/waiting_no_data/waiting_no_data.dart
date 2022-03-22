import 'package:flutter/material.dart';

class WaitingNoData extends StatelessWidget {
  const WaitingNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: const Text(
        'Pas de données',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}