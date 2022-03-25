import 'package:flutoo/models/auth/auth_provider.dart';
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
    /// on recupere le profil
    final auth = context.watch<AuthProvider>().authenticate;
    final user = context.watch<UserProvider>().user;

    /// active l'écouteur sur todos
    context.read<TodoProvider>().streamTodos(auth!.uid);

    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: widthTodo > 700 ? 700.0 : double.infinity,
        child: StreamBuilder<List<TodoSchema>>(
          stream: context.watch<TodoProvider>().todos,
          builder: (context, snapshot) {
            final List<TodoSchema>? todos;

            /// en chargement
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingData();
            }

            if (snapshot.hasData) {
              todos = snapshot.data;
            } else {
              return const WaitingData();
            }
            
            return Column(
              children: [
                /// titre de la page
                user != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: todos!.isNotEmpty
                            ? Text(
                                user.firstName! == "" || user.firstName == null
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
                                user.firstName! == "" || user.firstName == null
                                    ? 'Aucune tâche'
                                    : (user.firstName!
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            user.firstName!.substring(1)) +
                                        ', aucune tâche',
                                style: const TextStyle(fontSize: 28.0),
                              ),
                      )
                    : const CircularProgressIndicator(),

                /// input creation todo
                const TodoCreate(),
                // affiche la liste des todos
                TodoList(user: user),
              ],
            );
          },
        ),
      ),
    );
  }
}
