import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_list_head_table/condition_list_head_table.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionList extends StatefulWidget {
  const ConditionList({Key? key}) : super(key: key);

  @override
  State<ConditionList> createState() => _ConditionListState();
}

class _ConditionListState extends State<ConditionList> {
  @override
  Widget build(BuildContext context) {
    // ecouteur condition
    context.read<ConditionProvider>().streamConditions();

    return StreamBuilder(
      stream: context.watch<ConditionProvider>().conditions,
      builder: (BuildContext context,
          AsyncSnapshot<List<ConditionSchema>> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en attente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recupere les données
        final conditions = snapshot.data;

        return Container(
          child: Column(
            children: [
              /// head tableau condition
              const ConditionListHeadTable(),

              /// corp tableau condition
              Table(
                children: conditions!.map(
                  (condition) {
                    return TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                /// titre de la condition
                                Expanded(
                                  child: Text(
                                    condition.title!,
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),

                                /// cadre des btn
                                Row(
                                  children: [
                                    /// activer/desactiver condition
                                    Switch.adaptive(
                                      value: condition.activate!,
                                      onChanged: (value) => context
                                          .read<ConditionProvider>()
                                          .updateActivateCondition(
                                              context, value, condition),
                                    ),

                                    /// selected condition pour modification
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                    ),

                                    /// suppression de la condition
                                    IconButton(
                                      color: Colors.red,
                                      onPressed: () => context
                                          .read<ConditionProvider>()
                                          .deleteCondition(condition.id!),
                                      icon: const Icon(Icons.delete_outline),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
