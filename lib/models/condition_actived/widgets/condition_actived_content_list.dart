import 'package:flutoo/models/condition_actived/condition_actived_state.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class ConditionActivedcontentList extends ConsumerStatefulWidget {
  String? idCondition;
  String? idArticle;

  ConditionActivedcontentList(
      {Key? key, required this.idCondition, required this.idArticle})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionActivedcontentListState();
}

class _ConditionActivedcontentListState
    extends ConsumerState<ConditionActivedcontentList> {
  @override
  Widget build(BuildContext context) {

    /// creation du tuple pour envoyer 2 argument
    /// à la fonction future des contents
    Tuple2<String, String> t = Tuple2(widget.idCondition!, widget.idArticle!);

    return Container(
      child: Column(
        children: [
          ref.watch(contentsFuture(t))
            .when(
              error: (error, stack) => const WaitingError(),
              loading: () => const WaitingData(),
              data: (contents) {
                return Container(
                  child: Column(
                    children: contents.map((content) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            /// text du content
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  content.text!,
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
