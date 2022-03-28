import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<ConditionSchema>> _conditions;
  late Stream<ConditionSchema> _conditionSelected;

  Stream<List<ConditionSchema>> get conditions => _conditions;
  Stream<ConditionSchema> get conditionSelected => _conditionSelected;

  /// ecouteur conditions
  Future<void> streamConditions() async {
    _conditions = _firestoreService.streamCol<ConditionSchema>(
      path: FirestorePath.conditions(),
      builder: (data, documentId) => ConditionSchema.formMap(data, documentId),
    );
  }

  /// ecouteur condition selected
  Future<void> streamConditionSelected(String idCondition) async {
    _conditionSelected = _firestoreService.streamDoc(
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

    /// supprime tous les articles
    await articleProvider.deleteAllArticle(idCondition);

    /// delete condition
    await _firestoreService.delete(
      path: FirestorePath.condition(idCondition),
    );
    notifyListeners();
  }
}

/// state de la class conditionState
final conditionState = ChangeNotifierProvider((ref) => ConditionState());

/// state toute les conditions
final conditions = StreamProvider((ref) {
  ref.watch(conditionState).streamConditions();
  return ref.watch(conditionState).conditions;
});

/// state conditionSelected
final conditionSelect =
    StreamProvider((ref) => ref.watch(conditionState).conditionSelected);
