import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ConditionProvider extends ChangeNotifier {
  CollectionReference conditionApi =
      FirebaseFirestore.instance.collection('conditions');

  /// ecouteur collection conditions
  final Stream<QuerySnapshot<Map<String, dynamic>>> conditions =
      FirebaseFirestore.instance.collection('conditions').snapshots();

  /// creation d'un objet conditions
  Map<String, dynamic> createCondition(String? title) {
    return {'title': title, 'activate': false, 'date': Timestamp.now()};
  }

  Future<void> addCondition(String? title) async {
    await conditionApi.add(createCondition(title));
  }
}
