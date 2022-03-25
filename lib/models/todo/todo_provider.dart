import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class TodoProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<TodoSchema>> todos;

  /// ecouteur de la collection todos sur la proprieter uid
  Future<void> streamTodos(String uid) async {
    todos = _firestoreService.streamCol(
      path: FirestorePath.todos(),
      builder: (data, documentId) => TodoSchema.fromMap(data, documentId),
      queryBuilder: (query) => query.where('uid', isEqualTo: uid),
    );
  }

  /// ajoute une todo
  Future<void> addTodo(TodoSchema newTodo) async => await _firestoreService.add(
        path: FirestorePath.todos(),
        data: newTodo.toMap(),
      );

  /// modifie todo
  Future<void> updateTodo(String id, TodoSchema data) async =>
      await _firestoreService.update(
        path: FirestorePath.todo(id),
        data: data.toMap(),
      );

  /// delete une todo
  Future<void> deleteTodo(String id) async => await _firestoreService.delete(
        path: FirestorePath.todo(id),
      );
}
