import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutoo/models/condition/widgets/condition_create/condition_create_form.dart';
import 'package:flutoo/widget_shared/text_button_icon/text_button_icon.dart';
import 'package:flutter/material.dart';

class ConditionCreate extends StatefulWidget {
  const ConditionCreate({Key? key}) : super(key: key);

  @override
  State<ConditionCreate> createState() => _ConditionCreateState();
}

class _ConditionCreateState extends State<ConditionCreate> {
  bool seeAddCondition = false;

  /// affiche/cache volet creation condition
  void openCloseAddCondition() {
    setState(() {
      seeAddCondition = !seeAddCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Column(
        children: [
          /// bouton ajouter ou fermer
          Align(
              alignment: Alignment.centerLeft,
              child: TextButtonIcon(
                onPressed: () => openCloseAddCondition(),
                seeAddCondition: seeAddCondition,
                textbtn1: ConditionConstant.btnOpenCreate,
                textbtn2: ConditionConstant.btnCloseCreate,
              )),

          /// formulaire creation condition
          seeAddCondition
              ? ConditionCreateForm(
                  openCloseAddCondition: () => openCloseAddCondition(),
                )
              : Container(),
        ],
      ),
    );
  }
}
