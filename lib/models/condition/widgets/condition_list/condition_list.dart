import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_card/condition_list_card.dart';
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
    context.read<ConditionProvider>().streamConditions();

    return StreamBuilder(
      stream: context.watch<ConditionProvider>().allConditions,
      builder: (BuildContext context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recuperation sous forme de liste des conditions
        List<ConditionSchema> conditions =
            snapshot.data as List<ConditionSchema>;

        return Container(
          constraints: const BoxConstraints(minHeight: 50.0),
          margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: Column(
            children: [
              /// haut du tableau
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text('TITRE',
                                    style: TextStyle(fontSize: 26.0)),
                              ),
                              Text('ACTIONS', style: TextStyle(fontSize: 26.0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// corps du tableau
              Table(
                children: conditions.map(
                  (condition) {
                    return TableRow(
                      children: [
                        ConditionListCard(
                          id: condition.id,
                          title: condition.title,
                          activate: condition.activate,
                          date: condition.date,
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
