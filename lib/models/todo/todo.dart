import 'package:flutoo/models/todo/widgets/todo_create.dart';
import 'package:flutoo/models/todo/widgets/todo_list.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    double widthTodo = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: Column(
          children: [
            /// input creation todo
            TodoCreate(),
            // affiche la liste des todos
            const TodoList(),
          ],
        ),
      ),
    );
  }
}
