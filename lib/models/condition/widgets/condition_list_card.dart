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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TableCell(
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
                const IconButton(
                  /// TODO : ajouter selection condition et creer affichage detail condition
                  onPressed: null,
                  icon: Icon(Icons.edit),
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
