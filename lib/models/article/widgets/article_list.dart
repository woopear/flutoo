import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
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

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Form(
                        child: Column(children: [
                          InputCustom(
                            initialValue: data['title'],
                          )
                        ]),
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
