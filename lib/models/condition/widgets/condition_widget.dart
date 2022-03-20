import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/widgets/condition_create/condition_create.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_list.dart';
import 'package:flutoo/models/condition/widgets/condition_selected/condition_selected.dart';
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
    /// taille de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: Column(
          children: [
            const ConditionCreate(),
            const ConditionList(),
            /// si on a selectionné une condition
            /// on l'affiche sinon on affiche rien
            context.watch<ConditionProvider>().seeSelectCondition
                ? const ConditionSelected()
                : Container(),
          ],
        ),
      ),
    );
  }
}
