import 'package:flutoo/models/content_article/content_article_constant.dart';
import 'package:flutoo/models/content_article/widgets/content_article_list/content_article_list.dart';
import 'package:flutoo/widget_shared/text_button_icon/text_button_icon.dart';
import 'package:flutter/material.dart';

class ContentArticleWidget extends StatefulWidget {
  const ContentArticleWidget({Key? key}) : super(key: key);

  @override
  State<ContentArticleWidget> createState() => _ContentArticleWidgetState();
}

class _ContentArticleWidgetState extends State<ContentArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          /// title de la partie de la list des articles
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: Text(
              ContentArticleConstant.titleListContent,
              style: const TextStyle(fontSize: 28.0),
            ),
          ),

          /// btn ajoute content
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: Text(
              ContentArticleConstant.btnCreateContent,
              style: const TextStyle(fontSize: 18.0),
            ),
              ),
            ),
          ),

          /// list content
          const ContentArticleList(),
        ],
      ),
    );
  }
}
