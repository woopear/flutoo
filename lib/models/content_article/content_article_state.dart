import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_state.dart';
import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/models/content_article/content_article_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentArticleState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;

  late Stream<List<ContentArticleSchema>> _contents;

  Stream<List<ContentArticleSchema>> get contents => _contents;

  /// ecoute content de l'article selected
  Future<void> streamContents(String idCondition, String idArticle) async {
    _contents = _firestoreService.streamCol(
      path: FirestorePath.contentsOfArticle(idCondition, idArticle),
      builder: (data, documentId) =>
          ContentArticleSchema.fromMap(data, documentId),
    );
  }

  /// ajouter content à un article
  /// possibilité de passer en argument
  /// la valeur de text sinon sa sera une string vide
  Future<void> addContentOfArticle(
      String idCondition, String idArticle, ContentArticleSchema? data) async {
    final newContent = ContentArticleSchema(text: data?.text ?? "");

    await _firestoreService.add(
      path: FirestorePath.contentsOfArticle(idCondition, idArticle),
      data: newContent.toMap(),
    );
  }

  /// modification de tout les contents d'un article
  Future<void> updateContentsOfArticle(String idCondition, String idArticle,
      List<TextEditingController> data) async {
    /// init bach
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref path
    CollectionReference contents = FirebaseFirestore.instance.collection(
      FirestorePath.contentsOfArticle(idCondition, idArticle),
    );

    /// recuperation de contents
    final allContent = await contents.get();
    List<Map<String, dynamic>> l = [];

    /// transforme textEdeting en map
    for (var el in data) {
      final updateData = ContentArticleSchema(text: el.text);
      l.add(updateData.toMap());
    }

    /// modifie les document
    for (var i = 0; i < l.length; i++) {
      batch.update(allContent.docs[i].reference, l[i]);
    }

    return batch.commit();
  }

  /// delete un content
  Future<void> deleteContent(
      String idCondition, String idArticle, String idContent) async {
    await _firestoreService.delete(
      path: FirestorePath.contentOfArticle(idCondition, idArticle, idContent),
    );
    notifyListeners();
  }

  /// delete tous les content d'un article
  Future<void> deteleAllContent(String idCondition, String idArticle) async {
    /// instance firestore
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref path
    CollectionReference contents = FirebaseFirestore.instance.collection(
      FirestorePath.contentsOfArticle(idCondition, idArticle),
    );

    return contents.get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        batch.delete(document.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}

/// state de la class ContentArticleState
final contentArticleState =
    ChangeNotifierProvider<ContentArticleState>((ref) => ContentArticleState());

/// state des contents de l'article selectionné
final contentsOfArticleStream = StreamProvider((ref) {
  ref.watch(conditionSelect).whenData((condition) {
    ref.watch(articleSelectStream).whenData((article) {
      ref.watch(contentArticleState).streamContents(condition.id!, article.id!);
    });
  });
  return ref.watch(contentArticleState).contents;
});
