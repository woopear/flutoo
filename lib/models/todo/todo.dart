import 'package:flutoo/models/todo/widgets/todo_create.dart';
import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? libelle;
  bool? check;
  String? uid;

  Todo({this.id, this.libelle, this.check, this.uid});
}

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          TodoCreate(),
        ],
      ),
    );
  }
}
