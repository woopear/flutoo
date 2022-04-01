import 'package:flutoo/models/article/article_state.dart';
import 'package:flutoo/models/article/widgets/article_list/article_list_head_table.dart';
import 'package:flutoo/models/article/widgets/article_update/article_update.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleList extends ConsumerStatefulWidget {
  ConditionSchema conditionSelect;

  ArticleList({
    Key? key,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends ConsumerState<ArticleList> {
  bool seeShutterUpdateArticle = false;

  void openCloseUpdateArticle() {
    setState(() {
      seeShutterUpdateArticle = !seeShutterUpdateArticle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(allArticleOfConditionStream).when(
          data: (articles) {
            return Container(
              child: Column(
                children: [
                  /// entete du tabeleau
                  const ArticleListHeadTable(),

                  /// tableau de la list
                  Table(
                    children: articles.map(
                      (article) {
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
                                            ref
                                                .watch(articleState)
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
                                          onPressed: () => ref
                                              .watch(articleState)
                                              .deleteArticle(
                                                  widget.conditionSelect.id!,
                                                  article.id!),
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

                  /// update article
                  seeShutterUpdateArticle
                      ? ArticleUpdate(
                          openCloseUpdateArticle: () =>
                              openCloseUpdateArticle(),
                          conditionSelect: widget.conditionSelect)
                      : Container(),
                ],
              ),
            );
          },
          error: (error, stack) => const WaitingError(),
          loading: () => const WaitingData(),
        );
  }
}
