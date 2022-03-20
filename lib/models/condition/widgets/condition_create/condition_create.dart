import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/validator/condition_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionCreate extends StatefulWidget {
  const ConditionCreate({Key? key}) : super(key: key);

  @override
  State<ConditionCreate> createState() => _ConditionCreateState();
}

class _ConditionCreateState extends State<ConditionCreate> {
  bool seeAddCondition = false;
  String? inputTitle;
  final _formKey = GlobalKey<FormState>();

  /// afficher le volet d'ajouter une condition
  void seeShutterAddCondition() {
    setState(() => {
          seeAddCondition = !seeAddCondition,
        });
  }

  /// creation condition
  void createCondition(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation de la condition
      final condition = ConditionSchema(
        title: inputTitle,
        date: Timestamp.now(),
      );
      context.read<ConditionProvider>().addCondition(condition);

      /// partie reset all + fermeture du volet
      setState(() => {
            inputTitle = '',
          });
      _formKey.currentState!.reset();
      seeShutterAddCondition();

      /// widget message succes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Condition ajouter')),
      );
    } else {
      /// widget message error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: [
          /// bouton affiche/cache creation condition
          buttonSeeCreateCondition(),

          /// form creation condition
          seeAddCondition
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            /// input title
                            child: InputCustom(
                              margin: const EdgeInsets.only(right: 20.0),
                              labelText: 'titre de la condition',
                              validator: (value) =>
                                  ConditionValidator.validatorInputTitle(value),
                              onChange: (value) {
                                inputTitle = value;
                              },
                            ),
                          ),

                          /// btn create condition
                          ElevatedButton(
                            onPressed: () => createCondition(context),
                            child: const Text('Ajouter'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  /// bouton affiche/cache creation condition
  Widget buttonSeeCreateCondition() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Align(
            child: TextButton.icon(
              onPressed: () => seeShutterAddCondition(),
              icon: !seeAddCondition
                  ? const Icon(Icons.add)
                  : const Icon(Icons.close),
              label: !seeAddCondition
                  ? const Text(
                      'Ajouter une condition',
                      style: TextStyle(fontSize: 20.0),
                    )
                  : const Text(
                      'Fermer',
                      style: TextStyle(fontSize: 20.0),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
