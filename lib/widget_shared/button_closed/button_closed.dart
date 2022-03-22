import 'package:flutter/material.dart';

class ButtonClosed extends StatelessWidget {
  AlignmentGeometry alignement;
  Function() onPressed;

  ButtonClosed({
    Key? key,
    this.alignement = Alignment.centerRight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: alignement,
        child: IconButton(
          onPressed: () => onPressed(),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
