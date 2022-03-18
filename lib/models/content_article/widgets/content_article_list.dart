import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentArticleList extends StatefulWidget {
  String? idArticle;
  String? idCondition;
  List<TextEditingController>? controller;

  ContentArticleList({
    Key? key,
    this.idArticle,
    this.idCondition,
    this.controller,
  }) : super(key: key);

  @override
  State<ContentArticleList> createState() => _ContentArticleListState();
}

class _ContentArticleListState extends State<ContentArticleList> {
  @override
  Widget build(BuildContext context) {
    context
        .read<ContentArticleProvider>()
        .listenContentArticlesConition(widget.idArticle, widget.idCondition);

    return StreamBuilder(
      stream: context.watch<ContentArticleProvider>().contents,
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
                      print(widget.controller);

                return Column(
                  children: widget.controller!.map(
                    (e) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          controller: e,
                          maxLines: 8,
                          decoration: const InputDecoration(
                            labelText: "Ecriver votre texte",
                            alignLabelWithHint: true,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
