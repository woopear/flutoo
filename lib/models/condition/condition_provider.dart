import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ConditionProvider extends ChangeNotifier {
  CollectionReference conditionApi =
      FirebaseFirestore.instance.collection('conditions');

  /// ecouteur collection conditions
  final Stream<QuerySnapshot<Map<String, dynamic>>> conditions =
      FirebaseFirestore.instance.collection('conditions').snapshots();

  /// stocke la liste des conditions sous forme de listMap
  List<QueryDocumentSnapshot<Object?>>? conditionsStart;

  Map<String, dynamic>? condition;
  bool get seeOneCondition => condition != null;

  /// creation d'un objet conditions
  Map<String, dynamic> createCondition(String? title) {
    return {'title': title, 'activate': false, 'date': Timestamp.now()};
  }

  /// recupere l'ecouteur sour forme de tableau
  void findAllConditions(List<QueryDocumentSnapshot<Object?>> conditions) {
    conditionsStart = conditions;
  }

  /// selection d'un condition
  void selectedCondition(String? id) {
    /// recuperation des données avec l'id intégré
    final allConditions = conditionsStart!.map((document) {
      final f = document.data() as Map<String, dynamic>;
      f['id'] = document.id;
      return f;
    });

    /// on retourne le map souhaité et on l'attribue à la variable condition
    final listCondition = allConditions.where((e) => e['id'] == id).toList();
    condition = listCondition[0];
    notifyListeners();
  }

  /// ajouter condition
  Future<void> addCondition(String? title) async {
    await conditionApi.add(createCondition(title));
  }

  /// modifier condition
  Future<void> updateCondition(String? id, data) async {
    await conditionApi.doc(id).update(data);
  }

  /// supprimer condition
  Future<void> delCondition(String? id) async {
    await conditionApi.doc(id).delete();
  }
}
