import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/widgets/todo_update.dart';
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
  bool seeUpdate = false;

  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Card(
        child: Row(
          children: [
            seeUpdate
                ? Expanded(
                    child: TodoUpdate(
                      inputLibelle: widget.libelle,
                      id: widget.id,
                      closedUpdated: () => openCloseUpdated(),
                    ),
                  )
                : Expanded(
                    child: CheckboxListTile(
                      title: widget.check == true
                          ? Text(
                              widget.libelle,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : Text(
                              widget.libelle,
                            ),
                      value: widget.check,
                      onChanged: (newValue) {
                        context
                            .read<TodoProvider>()
                            .updateTodo(widget.id, {'check': newValue});
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
            seeUpdate
                ? IconButton(
                    onPressed: () {
                      openCloseUpdated();
                    },
                    color: Colors.red,
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    onPressed: () {
                      openCloseUpdated();
                    },
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.edit),
                  ),
            IconButton(
              onPressed: () {
                setState(() => {
                      context.read<TodoProvider>().delTodo(widget.id),
                    });
              },
              color: Colors.red,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
