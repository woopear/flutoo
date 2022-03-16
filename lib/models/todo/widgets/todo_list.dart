import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<TodoProvider>().todos,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const Text('Impossible de récupérer les données ...');
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// widget
        return Container(
          constraints: const BoxConstraints(minHeight: 200.0),
          margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: Column(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(document.id);
                return TodoCard(
                  libelle: data['libelle'],
                  check: data['check'],
                  id: document.id,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
