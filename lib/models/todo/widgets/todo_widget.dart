import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/models/todo/widgets/todo_create/todo_create.dart';
import 'package:flutoo/models/todo/widgets/todo_list/todo_list.dart';
import 'package:flutoo/models/user/user_provider.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
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
    /// active l'écouteur sur todos
    context.read<TodoProvider>().streamTodos();

    /// on recupere le profil
    final user = context.watch<UserProvider>().user;

    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: StreamBuilder<List<TodoSchema>>(
          stream: context.watch<TodoProvider>().todos,
          builder: (context, snapshot) {
            final List? todos;
            /// en chargement
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingData();
            }

            /// data recuperer sinon todos sera tableau vide
            if (snapshot.hasData) {
              todos = snapshot.data;
            } else {
              todos = [];
            }
            return Column(
              children: [
                /// titre de la page
                user != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: todos!.isNotEmpty
                        /// si il y a des taches
                            ? Text(
                                (user.firstName!.substring(0, 1).toUpperCase() +
                                        user.firstName!.substring(1)) +
                                    ', nombre de tâche : ' +
                                    todos.length.toString(),
                                style: const TextStyle(fontSize: 28.0),
                              )
                              /// si il y a pas de tache
                            : Text(
                                (user.firstName!.substring(0, 1).toUpperCase() +
                                        user.firstName!.substring(1)) +
                                    ", vous n'avez aucune tâche",
                                style: const TextStyle(fontSize: 28.0),
                              ),
                      )
                    : const CircularProgressIndicator(),

                /// input creation todo
                const TodoCreate(),
                // affiche la liste des todos
                const TodoList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
