import 'package:flutter/material.dart';

class WaitingData extends StatelessWidget {
  const WaitingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
  }
}
