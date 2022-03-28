import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/models/condition/widgets/condition_list/condition_list_head_table/condition_list_head_table.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionList extends ConsumerStatefulWidget {
  Function()? openCloseUpdateCondition;

  ConditionList({
    Key? key,
    required this.openCloseUpdateCondition,
  }) : super(key: key);

  @override
  _ConditionListState createState() => _ConditionListState();
}

class _ConditionListState extends ConsumerState<ConditionList> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(conditions).when(
          data: (conditions) {
            return Container(
              child: Column(
                children: [
                  /// head tableau condition
                  const ConditionListHeadTable(),

                  /// corp tableau condition
                  Table(
                    children: conditions.map(
                      (condition) {
                        return TableRow(
                          children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                          onChanged: (value) {
                                            ref
                                                .watch(conditionState)
                                                .updateActivateCondition(
                                                    value, condition);
                                          },
                                        ),

                                        /// selected condition pour modification
                                        IconButton(
                                          onPressed: () {
                                            /// selected condition
                                            ref
                                                .watch(conditionState)
                                                .streamConditionSelected(
                                                    condition.id!);

                                            /// open close volet update condition
                                            widget.openCloseUpdateCondition!();
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),

                                        /// suppression de la condition
                                        IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            ref
                                                .watch(conditionState)
                                                .deleteCondition(condition.id!);
                                          },
                                          icon:
                                              const Icon(Icons.delete_outline),
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
          error: (error, stack) => const WaitingError(),
          loading: () => const WaitingData(),
        );
  }
}
