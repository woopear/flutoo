import 'package:flutoo/models/article/widgets/article_create/article_create_form.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutter/material.dart';

class ArticleCreate extends StatefulWidget {
  Function() openCloseArticleCreate;
  ConditionSchema conditionSelect;

  ArticleCreate({
    Key? key,
    required this.openCloseArticleCreate,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  State<ArticleCreate> createState() => _ArticleCreateState();
}

class _ArticleCreateState extends State<ArticleCreate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Column(
        children: [
          /// formulaire creation article
          ArticleCreateForm(
            conditionSelect: widget.conditionSelect,
            openCloseArticleCreate: () => widget.openCloseArticleCreate(),
          ),
        ],
      ),
    );
  }
}
