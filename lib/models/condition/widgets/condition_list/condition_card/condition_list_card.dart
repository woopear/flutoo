import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionListCard extends StatefulWidget {
  String? id;
  String? title;
  bool? activate;
  Timestamp? date;

  ConditionListCard({
    Key? key,
    required this.id,
    required this.title,
    required this.activate,
    required this.date,
  }) : super(key: key);

  @override
  State<ConditionListCard> createState() => _ConditionListCardState();
}

/// switch activate condition
class _ConditionListCardState extends State<ConditionListCard> {
  void updateActivateCondition(BuildContext context, bool value) {
    /// update condition
    ConditionSchema updateCondition = ConditionSchema(
        title: widget.title, activate: value, date: widget.date);
    context
        .read<ConditionProvider>()
        .updateCondition(widget.id!, updateCondition);
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            /// titre de la condition
            Expanded(
              child: Text(
                widget.title!,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),

            /// cadre des btn
            Row(
              children: [
                /// activer/desactiver condition
                Switch.adaptive(
                  value: widget.activate!,
                  onChanged: (value) => updateActivateCondition(context, value),
                ),

                /// selected condition pour modification
                IconButton(
                  onPressed: () => context
                      .read<ConditionProvider>()
                      .streamSelectCondition(widget.id!),
                  icon: const Icon(Icons.edit),
                ),

                /// suppression de la condition
                IconButton(
                  color: Colors.red,
                  onPressed: () => context
                      .read<ConditionProvider>()
                      .deleteCondition(widget.id!),
                  icon: const Icon(Icons.delete_outline),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
