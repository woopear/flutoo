import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionSelected extends StatefulWidget {
  const ConditionSelected({Key? key}) : super(key: key);

  @override
  State<ConditionSelected> createState() => _ConditionSelectedState();
}

class _ConditionSelectedState extends State<ConditionSelected> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? conditionSelected =
        context.watch<ConditionProvider>().condition;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          /// fermeture de la modification de la condition
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

          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputCustom(
                        initialValue: conditionSelected!['title'],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: const ElevatedButton(
                        onPressed: null,
                        child: Text('Modifier'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
