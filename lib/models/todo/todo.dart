import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/models/todo/widgets/todo_create.dart';
import 'package:flutoo/models/todo/widgets/todo_list.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Bonjour ${currentUser!}'),

          /// input creation todo
          const TodoCreate(),
          // affiche la liste des todos
          const TodoList(),
        ],
      ),
    );
  }
}
