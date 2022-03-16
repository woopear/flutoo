import 'package:flutoo/models/condition/widgets/condition_add.dart';
import 'package:flutoo/models/condition/widgets/condition_list.dart';
import 'package:flutter/material.dart';

class ConditionWidget extends StatefulWidget {
  const ConditionWidget({Key? key}) : super(key: key);

  @override
  State<ConditionWidget> createState() => _ConditionWidgetState();
}

class _ConditionWidgetState extends State<ConditionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          ConditionAdd(),
          ConditionList(),
        ],
      ),
    );
  }
}
