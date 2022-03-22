import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/content_article/content_article_constant.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutoo/models/content_article/content_article_schema.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutoo/widget_shared/waiting_no_data/waiting_no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentArticleList extends StatefulWidget {
  ArticleSchema articleSelect;
  ConditionSchema conditionSelect;

  ContentArticleList({
    Key? key,
    required this.articleSelect,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  State<ContentArticleList> createState() => _ContentArticleListState();
}

class _ContentArticleListState extends State<ContentArticleList> {
  List<TextEditingController> textList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context
        .read<ContentArticleProvider>()
        .streamContents(widget.conditionSelect.id!, widget.articleSelect.id!);
    return StreamBuilder(
      stream: context.watch<ContentArticleProvider>().contents,
      builder: (context, AsyncSnapshot<List<ContentArticleSchema>> snapshot) {
        /// si pas de data
        if (!snapshot.hasData) {
          return const WaitingNoData();
        }

        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en attente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recupere les contents de l'article selected
        final contents = snapshot.data;

        return Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// les inputs des contents
                Column(
                  children: contents!.map((e) {
                    final text = TextEditingController(text: e.text);

                    textList.add(text);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          /// btn supprime un content
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<ContentArticleProvider>()
                                    .deleteContent(widget.conditionSelect.id!,
                                        widget.articleSelect.id!, e.id!);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),

                          /// texare pour content
                          TextField(
                            controller: text,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              labelText: "Ecriver votre texte",
                              alignLabelWithHint: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                /// btn enregistrer les contents
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<ContentArticleProvider>()
                          .updateContentsOfArticle(widget.conditionSelect.id!,
                              widget.articleSelect.id!, textList);
                      textList.clear();

                      /// message de confirmation
                      NotifMessage(
                        text: ContentArticleConstant.updateMessageSucces,
                        error: false,
                      ).notification(context);
                    },
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
