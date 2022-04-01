import 'package:flutter/material.dart';

class WaitingError extends StatelessWidget {
  const WaitingError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: const Text(
        'Impossible de récupérer les données ...',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
