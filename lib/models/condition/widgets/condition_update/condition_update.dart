import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/condition/widgets/condition_update/condition_update_form.dart';
import 'package:flutoo/widget_shared/button_closed/button_closed.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionUpdate extends StatefulWidget {
  Function() openCloseUpdateCondition;

  ConditionUpdate({
    Key? key,
    required this.openCloseUpdateCondition,
  }) : super(key: key);

  @override
  State<ConditionUpdate> createState() => _ConditionUpdateState();
}

class _ConditionUpdateState extends State<ConditionUpdate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.watch<ConditionProvider>().conditionSelected,
      builder: (BuildContext context, AsyncSnapshot<ConditionSchema> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en attente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        final conditionSelect = snapshot.data;

        print('CONDITION SELECT ::::: $conditionSelect');

        return Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              /// title de la condition + btn close update
              Row(
                children: [
                  /// title
                  Expanded(
                    child: Text(
                      conditionSelect!.title!,
                      style: const TextStyle(fontSize: 28.0),
                    ),
                  ),

                  /// btn close update
                  ButtonClosed(
                    onPressed: () => widget.openCloseUpdateCondition(),
                  ),
                ],
              ),

              /// form update title condition
              ConditionUpdateForm(
                conditionSelect: conditionSelect,
              ),

              /// creation d'articles

              /// list des articles
            ],
          ),
        );
      },
    );
  }
}
