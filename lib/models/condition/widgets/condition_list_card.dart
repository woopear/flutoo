import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionListCard<T> extends StatefulWidget {
  String id;
  String title;
  bool activate;

  ConditionListCard({
    Key? key,
    this.id = "",
    this.title = '',
    this.activate = false,
  }) : super(key: key);

  @override
  State<ConditionListCard> createState() => _ConditionListCardState();
}

class _ConditionListCardState extends State<ConditionListCard> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            Row(
              children: [
                Switch.adaptive(
                  value: widget.activate,
                  onChanged: (value) {
                    context
                        .read<ConditionProvider>()
                        .updateCondition(widget.id, {'activate': value});
                  },
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<ConditionProvider>()
                        .selectedCondition(widget.id);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () {
                    context.read<ConditionProvider>().delCondition(widget.id);
                  },
                  icon: const Icon(Icons.delete_outline),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
