import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({Key? key}) : super(key: key);

  @override
  State<TodoCreate> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  final _formKey = GlobalKey<FormState>();
  String? inputLibelle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputCustom(
                    label: const Text('Ajoutez une tâche'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une tâche valide';
                      }
                      return null;
                    },
                    onChange: (value) => inputLibelle = value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<TodoProvider>().addTodo(inputLibelle);
                        setState(() => {
                              inputLibelle = '',
                            });
                        _formKey.currentState!.reset();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tâche ajouter')),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Une erreur est survenue')),
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
