import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({Key? key}) : super(key: key);

  @override
  State<TodoCreate> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Form(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputCustom(label: const Text('Ajoutez une tâche'),),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: ElevatedButton(
                    onPressed: () => print('coucou'),
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
