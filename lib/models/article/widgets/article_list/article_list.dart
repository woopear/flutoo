import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/article/widgets/article_list/article_update/article_update.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleList extends StatefulWidget {
  String? idCondition;
  ArticleList({Key? key, required this.idCondition}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  Widget build(BuildContext context) {
    /// on recupere les articles de la condition selectionné
    context.read<ArticleProvider>().streamArticles(widget.idCondition!);

    return StreamBuilder(
      stream: context.watch<ArticleProvider>().articles,
      builder: (BuildContext context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        /// recuperation des articles sous forme de list
        List<ArticleSchema> articles = snapshot.data as List<ArticleSchema>;

        return Container(
          child: Column(
            children: [
              /// titre de la liste d'article
              const Text(
                'Liste des articles',
                style: TextStyle(fontSize: 24.0),
              ),

              /// liste des articles
              Column(
                children: articles.map(
                  (article) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          /// titre des articles
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 30.0, bottom: 20.0),
                              child: Text(
                                'Article : ' + article.title!,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),

                          /// formulaire du titre et des contents
                          ArticleUpdate(
                            article: article,
                            idCondition: widget.idCondition,
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
