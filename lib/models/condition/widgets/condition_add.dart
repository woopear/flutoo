import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionAdd extends StatefulWidget {
  const ConditionAdd({Key? key}) : super(key: key);

  @override
  State<ConditionAdd> createState() => _ConditionAddState();
}

class _ConditionAddState extends State<ConditionAdd> {
  final _formKey = GlobalKey<FormState>();
  bool seeAddCondition = false;
  String? inputTitle;

  /// afficher le volet d'ajouter une condition
  void seeShutterAddCondition() {
    setState(() => {
          seeAddCondition = !seeAddCondition,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// btn affiche add condition
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextButton(
              onPressed: () {
                seeShutterAddCondition();
              },
              child: Row(
                children: [
                  !seeAddCondition
                      ? const Text(
                          'Ajouter une condition',
                          style: TextStyle(fontSize: 20.0),
                        )
                      : const Text(
                          'Fermer',
                          style: TextStyle(fontSize: 20.0),
                        ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: !seeAddCondition
                        ? const Icon(Icons.add)
                        : const Icon(Icons.close),
                  )
                ],
              ),
            ),
          ),

          /// volet de creation de condition
          seeAddCondition
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InputCustom(
                              margin: const EdgeInsets.only(right: 20.0),
                              labelText: 'titre de la condition',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer titre valide';
                                }
                                return null;
                              },
                              onChange: (value) {
                                inputTitle = value;
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<ConditionProvider>()
                                    .addCondition(inputTitle);
                                setState(() => {
                                      inputTitle = '',
                                    });
                                _formKey.currentState!.reset();
                                seeShutterAddCondition();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Condition ajouter')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Une erreur est survenue')),
                                );
                              }
                            },
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
}
