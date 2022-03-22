import 'package:flutoo/models/article/article_constant.dart';
import 'package:flutter/material.dart';

class ArticleListHeadTable extends StatelessWidget {
  const ArticleListHeadTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                margin: const EdgeInsets.only(top: 30.0),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children:  [
                    /// 1er titre
                    Expanded(
                      child: Text(
                        ArticleConstant.headText1.toUpperCase(),
                        style: const TextStyle(fontSize: 26.0),
                      ),
                    ),

                    /// 2eme titre
                    Text(
                      ArticleConstant.headText2.toUpperCase(),
                      style: const TextStyle(fontSize: 26.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}