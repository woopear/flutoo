import 'package:flutter/material.dart';

class WaitingError extends StatelessWidget {
  const WaitingError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Impossible de récupérer les données ...');
  }
}