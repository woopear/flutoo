import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_card/todo_card.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  UserSchema? user;

  TodoList({Key? key, required this.user}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    /// active l'écouteur sur todos
    context.read<TodoProvider>().streamTodos(widget.user!.uid!);

    return StreamBuilder(
      stream: context.watch<TodoProvider>().todos,
      builder:
          (BuildContext context, AsyncSnapshot<List<TodoSchema>> snapshot) {
        final List todos;

        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        if (snapshot.data!.isEmpty) {
          todos = [];
        } else {
          /// trie du tableau affichant le derner créer en premier
          todos = snapshot.data!..sort((b, a) => a.date!.compareTo(b.date!));
        }

        /// widget todo card
        return Container(
          constraints: const BoxConstraints(minHeight: 200.0),
          margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: Column(
            children: todos.map(
              (todo) {
                return TodoCard(
                  uid: todo.uid,
                  libelle: todo.libelle,
                  check: todo.check,
                  id: todo.id,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
