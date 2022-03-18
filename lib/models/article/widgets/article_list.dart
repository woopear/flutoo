import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/content_article/widgets/content_article_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  String? inputTitle;

  @override
  Widget build(BuildContext context) {
    final idCondition = context.watch<ConditionProvider>().condition!['id'];
    final Stream<QuerySnapshot> articles =
        ArticleProvider().listenArticlesConition(idCondition)!;

    return StreamBuilder(
      stream: articles,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const Text('Impossible de récupérer les données ...');
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          child: Column(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                String titleArticle = data['title'];
                inputTitle = data['title'];

                /// liste des variables relier au input de text de l'article
                List<TextEditingController> listTexte = [];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 30.0, bottom: 20.0),
                          child: Text(
                            'Article : $titleArticle',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),

                      /// formulaire du titre et des contents
                      Form(
                        child: Column(
                          children: [
                            /// input titre de l'article
                            InputCustom(
                              labelText: "Titre de l'article",
                              initialValue: titleArticle,
                              onChange: (value) {
                                inputTitle = value;
                              },
                            ),

                            /// liste des contents des articles
                            ContentArticleList(
                              controller: listTexte,
                              idArticle: document.id,
                              idCondition: idCondition,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
