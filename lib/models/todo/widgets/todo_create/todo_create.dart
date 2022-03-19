import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
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

  /// validator du input libelle
  String? validatorInputLibelle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une tâche valide';
    }
    return null;
  }

  /// clique btn creation todo
  void createTodo(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation de la todo
      final newTodo = TodoSchema(libelle: inputLibelle, uid: 'leuid');
      context.read<TodoProvider>().addTodo(newTodo);

      /// reset variable pour input
      setState(() => {
            inputLibelle = '',
          });

      /// reset form
      _formKey.currentState!.reset();

      /// message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tâche ajouter')),
      );
    } else {
      /// message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),

      /// form creation todo
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                /// input libelle todo
                Expanded(
                  child: InputCustom(
                    label: const Text('Ajoutez une tâche'),
                    validator: (value) => validatorInputLibelle(value),
                    onChange: (value) => inputLibelle = value,
                  ),
                ),

                /// btn creation todo
                Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      createTodo(context);
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
