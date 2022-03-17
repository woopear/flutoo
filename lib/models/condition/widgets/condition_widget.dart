import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/widgets/condition_add.dart';
import 'package:flutoo/models/condition/widgets/condition_list.dart';
import 'package:flutoo/models/condition/widgets/condition_selected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionWidget extends StatefulWidget {
  const ConditionWidget({Key? key}) : super(key: key);

  @override
  State<ConditionWidget> createState() => _ConditionWidgetState();
}

class _ConditionWidgetState extends State<ConditionWidget> {
  @override
  Widget build(BuildContext context) {
    double widthTodo = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: Column(
          children: [
            const ConditionAdd(),
            const ConditionList(),
            /// si on a selectionné une condition
            context.watch<ConditionProvider>().seeOneCondition
                ? const ConditionSelected()
                : Container(),
          ],
        ),
      ),
    );
  }
}
