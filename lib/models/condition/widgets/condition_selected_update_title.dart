import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/widgets/condition_selected_update_add_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionSelectedUpdateTitle extends StatefulWidget {
  const ConditionSelectedUpdateTitle({Key? key}) : super(key: key);

  @override
  State<ConditionSelectedUpdateTitle> createState() =>
      _ConditionSelectedUpdateTitleState();
}

class _ConditionSelectedUpdateTitleState
    extends State<ConditionSelectedUpdateTitle> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? conditionSelected =
        context.watch<ConditionProvider>().condition;

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputCustom(
                    initialValue: conditionSelected!['title'],
                    labelText: 'Modifier le titre',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre valide';
                      }
                      return null;
                    },
                    onChange: (value) => conditionSelected['title'] = value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ConditionProvider>().updateCondition(
                            conditionSelected['id'],
                            {'title': conditionSelected['title']});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('titre modifié')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Une erreur est survenue')),
                        );
                      }
                    },
                    child: const Text('Modifier'),
                  ),
                ),
              ],
            ),

            /// ouvre le volet d'ajout d'article
            const ConditionSelectedUpdateAddArticle(),
          ],
        ),
      ),
    );
  }
}
