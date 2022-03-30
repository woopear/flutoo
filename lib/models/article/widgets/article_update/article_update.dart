import 'package:flutoo/models/article/article_state.dart';
import 'package:flutoo/models/article/widgets/article_update/article_update_form.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/content_article/widgets/content_article_widget.dart';
import 'package:flutoo/widget_shared/button_closed/button_closed.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleUpdate extends ConsumerStatefulWidget {
  ConditionSchema conditionSelect;
  Function() openCloseUpdateArticle;

  ArticleUpdate({
    Key? key,
    required this.conditionSelect,
    required this.openCloseUpdateArticle,
  }) : super(key: key);

  @override
  _ArticleUpdateState createState() => _ArticleUpdateState();
}

class _ArticleUpdateState extends ConsumerState<ArticleUpdate> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(articleSelectStream).when(
          data: (articleSelect) {
            return Container(
              margin: const EdgeInsets.only(top: 70.0, bottom: 30.0),
              child: Column(
                children: [
                  /// title article + btn close update article=
                  Row(
                    children: [
                      /// title
                      Expanded(
                        child: Text(
                          articleSelect.title!,
                          style: const TextStyle(fontSize: 28.0),
                        ),
                      ),

                      /// btn close update
                      ButtonClosed(
                        onPressed: () => widget.openCloseUpdateArticle(),
                      ),
                    ],
                  ),

                  /// formulaire update article
                  ArticleUpdateForm(
                    articleSelect: articleSelect,
                    conditionSelect: widget.conditionSelect,
                  ),

                  /// content widget (list de update content + create contente)
                  ContentArticleWidget(
                    articleSelect: articleSelect,
                    conditionSelect: widget.conditionSelect,
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
