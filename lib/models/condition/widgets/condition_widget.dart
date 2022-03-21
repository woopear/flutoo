import 'package:flutoo/models/condition/widgets/condition_create/condition_create.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_list.dart';
import 'package:flutter/material.dart';

class ConditionWidget extends StatefulWidget {
  const ConditionWidget({Key? key}) : super(key: key);

  @override
  State<ConditionWidget> createState() => _ConditionWidgetState();
}

class _ConditionWidgetState extends State<ConditionWidget> {
  @override
  Widget build(BuildContext context) {
    /// taille de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: Column(
          children: const [
            /// condition create
            ConditionCreate(),
            /// list condition
            ConditionList(),
          ],
        ),
      ),
    );
  }
}