import 'package:flutoo/models/article/widgets/article_form.dart';
import 'package:flutter/material.dart';

class ConditionSelectedUpdateAddArticle extends StatefulWidget {
  const ConditionSelectedUpdateAddArticle({Key? key}) : super(key: key);

  @override
  State<ConditionSelectedUpdateAddArticle> createState() =>
      _ConditionSelectedUpdateAddArticleState();
}

class _ConditionSelectedUpdateAddArticleState
    extends State<ConditionSelectedUpdateAddArticle> {
  bool seeArticleForm = false;

  void switchForSeeArticleForm() {
    setState(() {
      seeArticleForm = !seeArticleForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          /// btn ajouter un article + affiche le form
          Align(
            alignment: Alignment.centerLeft,
            child: 
            seeArticleForm ?
            TextButton.icon(
              onPressed: () => switchForSeeArticleForm(),
              icon: const Icon(Icons.close),
              label: 
              const Text(
                'Fermer',
                style: TextStyle(fontSize: 20.0),
              ),
            ) : TextButton.icon(
              onPressed: () => switchForSeeArticleForm(),
              icon: const Icon(Icons.add),
              label: 
              const Text(
                'Creer un article',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),

          /// formulaire de creation d'article
          seeArticleForm ?
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ArticleForm(switchForSeeArticleForm: switchForSeeArticleForm),
          ) : Container(),
        ],
      ),
    );
  }
}
