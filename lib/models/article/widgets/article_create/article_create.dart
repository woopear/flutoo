import 'package:flutter/material.dart';

class ArticleCreate extends StatefulWidget {
  const ArticleCreate({Key? key}) : super(key: key);

  @override
  State<ArticleCreate> createState() => _ArticleCreateState();
}

class _ArticleCreateState extends State<ArticleCreate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      child: const Text('coucou'),
    );
  }
}