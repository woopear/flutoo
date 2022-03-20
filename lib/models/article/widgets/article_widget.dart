import 'package:flutoo/models/article/widgets/article_list/article_list.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatefulWidget {
  String? idCondition;
  ArticleWidget({Key? key, required this.idCondition}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// ajouter un article

          /// list des articles
          ArticleList(
            idCondition: widget.idCondition,
          ),
        ],
      ),
    );
  }
}
