import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_card/todo_update/todo_update.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatefulWidget {
  String? libelle;
  bool? check;
  String? id;

  TodoCard({
    Key? key,
    required this.libelle,
    required this.check,
    required this.id,
  }) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool seeUpdate = false;

  /// affiche/cache volet update todo
  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  /// update todo, checked ou pas checked
  void checkedBox({
    required BuildContext context,
    required bool? newValue,
  }) {
    final checked = TodoSchema(check: newValue);
    context.read<TodoProvider>().updateTodo(widget.id!, checked);
  }

  /// supprime la todo
  void deleteTodo({required BuildContext context}) {
    context.read<TodoProvider>().deleteTodo(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Card(
        child: Row(
          children: [
            /// si on modifie on affiche todoUpdate sinon
            /// on affiche checkbox
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
                      /// si checked on barre le libelle
                      title: widget.check == true
                          ? Text(
                              widget.libelle!,
                              style: GoogleFonts.indieFlower(
                                fontSize: 18.0,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : Text(
                              widget.libelle!,
                              style: GoogleFonts.indieFlower(fontSize: 20.0),
                            ),
                      value: widget.check,
                      onChanged: (newValue) => checkedBox(
                        context: context,
                        newValue: newValue,
                      ),
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),

            /// si volet ouvert on affiche le logo closed en rouge
            /// sinon on affiche le logo edit
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

            /// btn delete todo
            IconButton(
              onPressed: () => deleteTodo(context: context),
              color: Colors.red,
              icon: const Icon(Icons.delete_outline_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
