import 'package:flutter/material.dart';

class TextButtonIcon extends StatelessWidget {
  Function()? onPressed;
  bool seeAddCondition;
  String textbtn1;
  String textbtn2;

  TextButtonIcon({
    Key? key,
    this.onPressed,
    required this.seeAddCondition,
    required this.textbtn1,
    required this.textbtn2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !seeAddCondition
        ? TextButton.icon(
            onPressed: () => onPressed!(),
            icon: const Icon(Icons.add),
            label: Text(
              textbtn1,
              style: const TextStyle(fontSize: 18.0),
            ),
          )
        : TextButton.icon(
            onPressed: () => onPressed!(),
            icon: const Icon(Icons.close),
            label: Text(
              textbtn2,
              style: const TextStyle(fontSize: 18.0),
            ),
          );
  }
}
