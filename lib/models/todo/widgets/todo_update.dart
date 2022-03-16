import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class TodoUpdate extends StatefulWidget {
  String? inputLibelle;
  String? id;
  void Function()? closedUpdated;
  TodoUpdate({Key? key, this.inputLibelle, this.id, this.closedUpdated})
      : super(key: key);

  @override
  State<TodoUpdate> createState() => _TodoUpdateState();
}

class _TodoUpdateState extends State<TodoUpdate> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputCustom(
                    initialValue: widget.inputLibelle,
                    label: const Text('modifier la tâche'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une tâche valide';
                      }
                      return null;
                    },
                    onChange: (value) => widget.inputLibelle = value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    style: const ButtonStyle().copyWith(
                      textStyle: MaterialStateProperty.all<TextStyle?>(
                        const TextStyle().copyWith(fontSize: 12.0),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        const EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<TodoProvider>().updateTodo(
                            widget.id, {'libelle': widget.inputLibelle});
                        widget.closedUpdated!();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tâche modifiée')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Une erreur est survenue')),
                        );
                      }
                    },
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
