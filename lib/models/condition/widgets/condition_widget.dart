import 'package:flutoo/models/condition/widgets/condition_create/condition_create.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_list.dart';
import 'package:flutoo/models/condition/widgets/condition_update/condition_update.dart';
import 'package:flutter/material.dart';

class ConditionWidget extends StatefulWidget {
  const ConditionWidget({Key? key}) : super(key: key);

  @override
  State<ConditionWidget> createState() => _ConditionWidgetState();
}

class _ConditionWidgetState extends State<ConditionWidget> {
  bool seeUpdateCondition = false;

  /// open/close volet update condition
  void openCloseUpdateCondition() {
    setState(() {
      seeUpdateCondition = !seeUpdateCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// taille de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 60.0),
        /// taille ecran
        width: widthTodo > 700 ? 700.0 : double.infinity,

        child: Column(
          children: [
            /// condition create
            const ConditionCreate(),

            /// list condition
            ConditionList(
                openCloseUpdateCondition: () => openCloseUpdateCondition()),

            /// update condition
            seeUpdateCondition
                ? ConditionUpdate(
                    openCloseUpdateCondition: () => openCloseUpdateCondition(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
