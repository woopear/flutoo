import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutter/material.dart';

class ConditionListHeadTable extends StatelessWidget {
  const ConditionListHeadTable({Key? key}) : super(key: key);

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
                        ConditionConstant.headText1.toUpperCase(),
                        style: const TextStyle(fontSize: 26.0),
                      ),
                    ),

                    /// 2eme titre
                    Text(
                      ConditionConstant.headText2.toUpperCase(),
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
