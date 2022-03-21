import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/content_article/widgets/content_article_list.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleUpdate extends StatefulWidget {
  ArticleSchema? article;
  String? idCondition;
  ArticleUpdate({Key? key, required this.article, required this.idCondition})
      : super(key: key);

  @override
  State<ArticleUpdate> createState() => _ArticleUpdateState();
}

class _ArticleUpdateState extends State<ArticleUpdate> {
  String? inputTitle;

  /// liste des variables relier au input de text de l'article
  List<TextEditingController> listTexte = [];

  void addTextEditing(TextEditingController value) {
    listTexte.add(value);
  }

  @override
  void dispose() {
    listTexte.map((e) => e.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// init inputValueTitle avec le titre en cour de l'article
    inputTitle = widget.article!.title;

    return Column(
      children: [
        /// titre des articles
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Text(
              'Article : ' + widget.article!.title!,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        Form(
          child: Column(
            children: [
              /// input titre de l'article
              InputCustom(
                labelText: "Titre de l'article",
                initialValue: widget.article!.title,
                onChange: (value) {
                  inputTitle = value;
                },
              ),

              /// liste des contents des articles
              ContentArticleList(
                article: widget.article!,
                idCondition: widget.idCondition,
                controller: (value) => addTextEditing(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
