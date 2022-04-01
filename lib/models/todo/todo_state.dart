import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/utils/services/fireauth/fireauth_service.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<TodoSchema>?> _todos;

  Stream<List<TodoSchema>?> get todos => _todos;

  /// ecouteur de la collection todos sur la proprieter uid
  Future<void> streamTodos(String uid) async {
    _todos = _firestoreService.streamCol(
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

/// state de la class TodoState
final todoState = ChangeNotifierProvider<TodoState>((ref) => TodoState());

/// state des todos du user connecter
final todosUser = StreamProvider<List<TodoSchema>?>((ref) {
  ref.watch(auth).whenData((value) {
    ref.watch(todoState).streamTodos(value!.uid);
  });
  return ref.watch(todoState).todos;
});
