import 'package:flutoo/models/article/widgets/article_create/article_create_btn_add.dart';
import 'package:flutoo/models/article/widgets/article_create/article_form.dart';
import 'package:flutter/material.dart';

class ArticleCreate extends StatefulWidget {
  String? idCondition;
  ArticleCreate({
    Key? key,
    required this.idCondition,
  }) : super(key: key);

  @override
  State<ArticleCreate> createState() => _ArticleCreateState();
}

class _ArticleCreateState extends State<ArticleCreate> {
  bool seeArticleForm = false;

  /// affiche/cacher le volet du formulaire de creation article
  void switchForSeeArticleForm() {
    setState(() {
      seeArticleForm = !seeArticleForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 50.0),
      child: Column(
        children: [
          /// btn pour afficher/cacher volet de creation
          ArticleCreateBtnAdd(
            seeArticleForm: seeArticleForm,
            switchForSeeArticleForm: () => switchForSeeArticleForm(),
          ),

          /// fomulaire de creation article
          seeArticleForm
              ? ArticleForm(
                  idCondition: widget.idCondition,
                  seeArticleForm: seeArticleForm,
                  switchForSeeArticleForm: () => switchForSeeArticleForm(),
                )
              : Container(),
        ],
      ),
    );
  }
}
