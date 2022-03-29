import 'package:flutoo/models/todo/todo_state.dart';
import 'package:flutoo/models/todo/widgets/todo_create/todo_create.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_list.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoWidget extends ConsumerStatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends ConsumerState<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    /// recupere le user current
    final user = ref.watch(userCurrent);

    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: ref.watch(todosUser).when(
              data: (todos) {
                
                return Column(
                  children: [
                    /// titre de la page
                    Container(
                      margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                      child: todos!.isNotEmpty
                          ? Text(
                              user?.firstName == null || user!.firstName! == "" 
                                  ? 'nombre de tâche : ' +
                                      todos.length.toString()
                                  : (user.firstName!
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          user.firstName!.substring(1)) +
                                      ', nombre de tâche : ' +
                                      todos.length.toString(),
                              style: const TextStyle(fontSize: 28.0),
                            )

                          /// si il y a pas de tache
                          : Text(
                              user?.firstName == null || user!.firstName! == "" 
                                  ? 'Aucune tâche'
                                  : (user.firstName!
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          user.firstName!.substring(1)) +
                                      ', aucune tâche',
                              style: const TextStyle(fontSize: 28.0),
                            ),
                    ),
                    
                    /// input creation todo
                    const TodoCreate(),
                    
                    // affiche la liste des todos
                    const TodoList(),
                    
                  ],
                );
              },
              error: (error, stack) => const WaitingError(),
              loading: () => const WaitingData(),
            ),
      ),
    );
  }
}
