import 'package:flutoo/models/todo/widgets/todo_create/todo_create.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_list.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    String? firstname = context.watch<UserProvider>().user?.firstName;

    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: Column(
          children: [
            /// titre de la page
            firstname != null
                ? Container(
                  margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Text(
                      'Bienvenue $firstname',
                      style: const TextStyle(fontSize: 28.0),
                    ),
                  )
                : const CircularProgressIndicator(),

            /// input creation todo
            const TodoCreate(),
            // affiche la liste des todos
            const TodoList(),
          ],
        ),
      ),
    );
  }
}
