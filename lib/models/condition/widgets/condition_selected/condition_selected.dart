import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/widgets/condition_selected/condition_selected_update/condition_selected_update_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionSelected extends StatefulWidget {
  const ConditionSelected({Key? key}) : super(key: key);

  @override
  State<ConditionSelected> createState() => _ConditionSelectedState();
}

class _ConditionSelectedState extends State<ConditionSelected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          /// Btn fermeture de la 
          /// modification de la condition
          Container(
            margin: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  context.read<ConditionProvider>().resetConditionSelected();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),

          /// formulaire de modification 
          /// du titre de la condition selectionné
          const ConditionSelectedUpdateTitle(),
        ],
      ),
    );
  }
}
