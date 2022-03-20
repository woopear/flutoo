import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentArticleList extends StatefulWidget {
  ArticleSchema? article;
  String? idCondition;
  List<TextEditingController>? controller;

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
        .listenContentArticlesConition(widget.article!.id, widget.idCondition);

    return StreamBuilder(
      stream: context.watch<ContentArticleProvider>().contents,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
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
