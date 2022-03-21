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
                  children: const [
                    Expanded(
                      child: Text('TITRE', style: TextStyle(fontSize: 26.0)),
                    ),
                    Text('ACTIONS', style: TextStyle(fontSize: 26.0)),
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
