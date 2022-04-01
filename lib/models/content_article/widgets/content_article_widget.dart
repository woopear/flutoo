import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/content_article/content_article_constant.dart';
import 'package:flutoo/models/content_article/content_article_state.dart';
import 'package:flutoo/models/content_article/widgets/content_article_list/content_article_list.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentArticleWidget extends ConsumerStatefulWidget {
  ArticleSchema articleSelect;
  ConditionSchema conditionSelect;

  ContentArticleWidget({
    Key? key,
    required this.articleSelect,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  _ContentArticleWidgetState createState() => _ContentArticleWidgetState();
}

class _ContentArticleWidgetState extends ConsumerState<ContentArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          /// title de la partie de la list des articles
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: Text(
              ContentArticleConstant.titleListContent,
              style: const TextStyle(fontSize: 28.0),
            ),
          ),

          /// btn ajoute content
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  ref.watch(contentArticleState).addContentOfArticle(
                        widget.conditionSelect.id!,
                        widget.articleSelect.id!,
                        null,
                      );

                  /// message de confirmation
                  NotifMessage(
                    text: ContentArticleConstant.createMessageSucces,
                    error: false,
                  ).notification(context);
                },
                icon: const Icon(Icons.add),
                label: Text(
                  ContentArticleConstant.btnCreateContent,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),

          /// list content
          ContentArticleList(
            articleSelect: widget.articleSelect,
            conditionSelect: widget.conditionSelect,
          ),
        ],
      ),
    );
  }
}
