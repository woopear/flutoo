import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutter/material.dart';

class ArticleList extends StatefulWidget {
  ConditionSchema conditionSelect;

  ArticleList({
    Key? key,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
