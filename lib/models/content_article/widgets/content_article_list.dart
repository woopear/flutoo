import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutoo/models/content_article/content_article_schema.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentArticleList extends StatefulWidget {
  ArticleSchema? article;
  String? idCondition;
  Function(TextEditingController)? controller;

  ContentArticleList({
    Key? key,
    required this.article,
    required this.idCondition,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContentArticleList> createState() => _ContentArticleListState();
}

class _ContentArticleListState extends State<ContentArticleList> {
  @override
  Widget build(BuildContext context) {
    context
        .read<ContentArticleProvider>()
        .streamContentOfArticle(widget.article!.id!, widget.idCondition!);

    return StreamBuilder(
      stream: context.watch<ContentArticleProvider>().contentsOfArticle,
      builder: (BuildContext context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recuperation des content d'un article
        List<ContentArticleSchema> contents =
            snapshot.data as List<ContentArticleSchema>;

        return Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: contents.map(
              (content) {
                TextEditingController inputContentText =
                    TextEditingController(text: content.text);
                widget.controller!(
                  inputContentText,
                );

                return Column(
                  children: [
                    /// btn supprime content
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => context
                            .read<ContentArticleProvider>()
                            .deleteContentOfArticle(widget.article!.id!,
                                widget.idCondition, content.id),
                        icon: const Icon(Icons.close),
                      ),
                    ),

                    /// textarea content text
                    Container(
                      child: TextField(
                        controller: inputContentText,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: "Ecriver votre texte",
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() => {
                                  listText.add(TextEditingController()),
                                });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Ajouter un texte',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),

                    /// btn form
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => createArticle(context),
                          child: const Text('Enregistrer'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  /// btn ajoute un content à l'article
  Widget addContentArticle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () {
            setState(() => {
                  listText.add(TextEditingController()),
                });
          },
          icon: const Icon(Icons.add),
          label: const Text(
            'Ajouter un texte',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
