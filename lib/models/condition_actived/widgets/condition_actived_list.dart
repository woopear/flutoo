import 'package:flutoo/models/condition_actived/condition_actived_state.dart';
import 'package:flutoo/models/condition_actived/widgets/condition_actived_article_list.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionActivedList extends ConsumerStatefulWidget {
  const ConditionActivedList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionActivedListState();
}

class _ConditionActivedListState extends ConsumerState<ConditionActivedList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ref.watch(conditionActivateStream).when(
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
                data: (conditions) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: conditions.map((condition) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                /// title page
                                Text(
                                  condition.title!,
                                  style: const TextStyle(fontSize: 36.0),
                                ),

                                /// date
                                Text(
                                  'du ${condition.date!.toDate().month < 10 ? '0' + condition.date!.toDate().month.toString() : condition.date!.toDate().month.toString()} / ${condition.date!.toDate().year.toString()}',
                                  style: const TextStyle(fontSize: 13.0),
                                ),

                                /// articles
                                ConditionActivedArticleList(idCondition: condition.id!),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
