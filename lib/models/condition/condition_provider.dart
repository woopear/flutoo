import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ConditionProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<ConditionSchema>> conditions;
  late Stream<ConditionSchema> conditionSelected;

  /// ecouteur conditions
  Future<void> streamConditions() async {
    conditions = _firestoreService.streamCol<ConditionSchema>(
      path: FirestorePath.conditions(),
      builder: (data, documentId) => ConditionSchema.formMap(data, documentId),
    );
  }

  /// ecouteur condition selected
  Future<void> streamConditionSelected(String idCondition) async {
    conditionSelected = _firestoreService.streamDoc(
      path: FirestorePath.condition(idCondition),
      builder: (data, documentId) => ConditionSchema.formMap(data, documentId),
    );
  }

  /// creation condition
  Future<void> addCondition(String title) async {
    ConditionSchema createCondition =
        ConditionSchema(title: title, date: Timestamp.now());

    await _firestoreService.add(
      path: FirestorePath.conditions(),
      data: createCondition.toMap(),
    );
    notifyListeners();
  }

  /// update title condition
  Future<void> updateTitleCondition(String value, ConditionSchema data) async {
    ConditionSchema updateCondition =
        ConditionSchema(title: value, activate: data.activate, date: data.date);

    await _firestoreService.update(
      path: FirestorePath.condition(data.id!),
      data: updateCondition.toMap(),
    );
    notifyListeners();
  }

  /// update activate condition
  Future<void> updateActivateCondition(bool value, ConditionSchema data) async {
    ConditionSchema updateCondition =
        ConditionSchema(title: data.title, activate: value, date: data.date);

    await _firestoreService.update(
      path: FirestorePath.condition(data.id!),
      data: updateCondition.toMap(),
    );
    notifyListeners();
  }

  /// supprime une condition
  Future<void> deleteCondition(String idCondition) async {
    final articleProvider = ArticleProvider();

    await articleProvider.deleteAllArticle(idCondition);

    await _firestoreService.delete(
      path: FirestorePath.condition(idCondition),
    );
      notifyListeners();

  }
}
