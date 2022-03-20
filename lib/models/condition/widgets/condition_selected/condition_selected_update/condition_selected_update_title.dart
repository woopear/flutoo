import 'package:flutoo/models/article/widgets/article_widget.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/validator/condition_validator.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
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

  /// update le title de la condition selectionnée
  void updateTitleCondition(BuildContext context, ConditionSchema value) {
    if (_formKey.currentState!.validate()) {
      /// update condition
      final updateCondition = ConditionSchema(
        title: value.title,
        activate: value.activate,
        date: value.date,
      );
      context
          .read<ConditionProvider>()
          .updateCondition(value.id!, updateCondition);

      /// widget message de succes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('titre modifié')),
      );
    } else {
      /// widget message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.watch<ConditionProvider>().selectCondition,
      builder: (BuildContext context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recuperation de la condition selectionné
        ConditionSchema condition = snapshot.data as ConditionSchema;

        return Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    /// form pour modification du titre
                    /// de la condition selectionner
                    Expanded(
                      child: InputCustom(
                        initialValue: condition.title,
                        labelText: 'Modifier le titre',
                        validator: (value) =>
                            ConditionValidator.validatorInputTitle(value),
                        onChange: (value) => condition.title = value,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        onPressed: () =>
                            updateTitleCondition(context, condition),
                        child: const Text('Modifier'),
                      ),
                    ),
                  ],
                ),

                /// ouvre le volet d'ajout d'article
                ArticleWidget(idCondition: condition.id),
              ],
            ),
          ),
        );
      },
    );
  }
}
