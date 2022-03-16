import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class TodoProvider extends ChangeNotifier {
  CollectionReference todoApi = FirebaseFirestore.instance.collection('todos');

  /// ecouteur de la collection todo
  final Stream<QuerySnapshot<Map<String, dynamic>>> todos =
      FirebaseFirestore.instance.collection('todos').snapshots();

  /// creation d'un objet todo
  Map<String, dynamic> createTodo(String? libelle) {
    return {'libelle': libelle, 'check': false, 'uid': 'ddsfdsfsdfsfsdf'};
  }

  /// ajoute une todo
  Future<void> addTodo(String? libelle) async {
    await todoApi.add(createTodo(libelle));
  }

  /// modifie todo
  Future<void> updateTodo(String? id, data) async {
    await todoApi.doc(id).update(data);
  }

  /// delete une todo
  Future<void> delTodo(String? id) async {
    await todoApi.doc(id).delete();
  }
}
