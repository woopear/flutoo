import 'dart:async';

import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ConditionProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<ConditionSchema>> allConditions;
  Stream<ConditionSchema>? selectCondition;

  /// détermine si oui ou non selectCondition à été init
  bool get seeSelectCondition => selectCondition != null;

  /// ecouteur collection conditions
  Future<void> streamConditions() async {
    allConditions = _firestoreService.streamCol(
      path: FirestorePath.conditions(),
      builder: (data, documentId) => ConditionSchema.fromMap(data, documentId),
    );
  }

  /// ajouter une condition
  Future<void> addCondition(ConditionSchema data) async {
    await _firestoreService.add(
      path: FirestorePath.conditions(),
      data: data.toMap(),
    );
  }

  /// modification de la condition
  Future<void> updateCondition(String idCondition, ConditionSchema data) async {
    await _firestoreService.update(
      path: FirestorePath.condition(idCondition),
      data: data.toMap(),
    );
  }

  /// delete condition
  Future<void> deleteCondition(String id) async {
    /// TODO: ATTENTION rendre impossible de supprimer
    /// TODO: si il y a des articles ratacher à la condition
    await _firestoreService.delete(
      path: FirestorePath.condition(id),
    );
  }

  /// ecoute un document d'une condition
  /// * represente le document selectionné
  Future<void> streamSelectCondition(String id) async {
    selectCondition = _firestoreService.streamDoc(
      path: FirestorePath.condition(id),
      builder: (data, documentId) => ConditionSchema.fromMap(data, documentId),
    );
    notifyListeners();
  }

  /// reset condition selectionné
  void resetConditionSelected() {
    selectCondition = null;
    notifyListeners();
  }
}
