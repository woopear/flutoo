import 'package:flutoo/models/condition_actived/condition_actived_state.dart';
import 'package:flutoo/models/condition_actived/widgets/condition_actived_content_list.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionActivedArticleList extends ConsumerStatefulWidget {
  String? idCondition;
  ConditionActivedArticleList({Key? key, required this.idCondition})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionActivedArticleListState();
}

class _ConditionActivedArticleListState
    extends ConsumerState<ConditionActivedArticleList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          ref.watch(articlesOfConditionStream).when(
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
                data: (articles) {
                  return Container(
                    child: Column(
                      children: articles.map((article) {
                        ref
                            .watch(conditionActivedState)
                            .streamContents(widget.idCondition!, article.id!);
                        return Container(
                          child: Column(
                            children: [
                              /// titre article
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    article.title!,
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),

                              /// liste des content
                              const ConditionActivedcontentList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
