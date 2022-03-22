import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/article/widgets/article_list/article_list_head_table.dart';
import 'package:flutoo/models/article/widgets/article_update/article_update.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleList extends StatefulWidget {
  ConditionSchema conditionSelect;

  ArticleList({
    Key? key,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  bool seeShutterUpdateArticle = false;

  void openCloseUpdateArticle() {
    setState(() {
      seeShutterUpdateArticle = !seeShutterUpdateArticle;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// active ecouteur articles
    context.read<ArticleProvider>().streamArticles(widget.conditionSelect.id!);

    return StreamBuilder(
      stream: context.watch<ArticleProvider>().articlesOfCondition,
      builder:
          ((BuildContext context, AsyncSnapshot<List<ArticleSchema>> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en attente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recupere tous les articles de la condition
        final articles = snapshot.data;

        return Container(
          child: Column(
            children: [
              /// entete du tabeleau
              const ArticleListHeadTable(),

              /// tableau de la list
              Table(
                children: articles!.map(
                  (article) {
                    return TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                /// titre de la condition
                                Expanded(
                                  child: Text(
                                    article.title!,
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),

                                /// cadre des btn
                                Row(
                                  children: [
                                    /// selected article pour modification
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<ArticleProvider>()
                                            .streamArticleSelected(
                                                widget.conditionSelect.id!,
                                                article.id!);

                                        openCloseUpdateArticle();
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),

                                    /// suppression de la condition
                                    IconButton(
                                      color: Colors.red,
                                      onPressed: () => context
                                          .read<ArticleProvider>()
                                          .deleteArticle(
                                              widget.conditionSelect.id!,
                                              article.id!),
                                      icon: const Icon(Icons.delete_outline),
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

              /// update article
              seeShutterUpdateArticle
                  ? ArticleUpdate(
                      openCloseUpdateArticle: () => openCloseUpdateArticle(),
                      conditionSelect: widget.conditionSelect)
                  : Container(),
            ],
          ),
        );
      }),
    );
  }
}
