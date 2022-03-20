import 'package:flutter/material.dart';

class ArticleCreateBtnAdd extends StatefulWidget {
  Function()? switchForSeeArticleForm;
  bool? seeArticleForm;
  
  ArticleCreateBtnAdd({
    Key? key,
    required this.switchForSeeArticleForm,
    required this.seeArticleForm,
  }) : super(key: key);

  @override
  State<ArticleCreateBtnAdd> createState() => _ArticleCreateBtnAddState();
}

class _ArticleCreateBtnAddState extends State<ArticleCreateBtnAdd> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: widget.seeArticleForm!

          /// icon closed
          ? TextButton.icon(
              onPressed: () => widget.switchForSeeArticleForm!(),
              icon: const Icon(Icons.close),
              label: const Text(
                'Fermer',
                style: TextStyle(fontSize: 20.0),
              ),
            )

          /// icon ajouter
          : TextButton.icon(
              onPressed: () => widget.switchForSeeArticleForm!(),
              icon: const Icon(Icons.add),
              label: const Text(
                'Creer un article',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
    );
  }
}
