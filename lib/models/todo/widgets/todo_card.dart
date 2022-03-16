import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatefulWidget {
  String libelle;
  bool? check;
  String? id;
  TodoCard({Key? key, this.libelle = '', this.check, this.id})
      : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: Text(widget.libelle),
                value: widget.check,
                onChanged: (newValue) {
                  print(newValue);
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                setState(() => {
                      context.read<TodoProvider>().delTodo(widget.id),
                    });
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
