import 'package:flutoo/models/todo/todo_state.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_card/todo_card.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList extends ConsumerStatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends ConsumerState<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(todosUser).when(
          data: (todos) {
            return Container(
              constraints: const BoxConstraints(minHeight: 200.0),
              margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
              child: Column(
                children: todos!.map(
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
          error: (error, stack) => const WaitingError(),
          loading: () => const WaitingData(),
        );
  }
}
