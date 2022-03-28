import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/models/content_article/content_article_state.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;

  late Stream<List<ArticleSchema>> _articlesOfCondition;
  late Stream<ArticleSchema> _articleSelected;

  Stream<List<ArticleSchema>> get articlesOfCondition => _articlesOfCondition;
  Stream<ArticleSchema> get articleSelected => _articleSelected;

  /// ecouteur articles
  Future<void> streamArticles(String idCondition) async {
    _articlesOfCondition = _firestoreService.streamCol(
      path: FirestorePath.articlesOfCondition(idCondition),
      builder: (data, documentId) => ArticleSchema.fromMap(data, documentId),
    );
  }

  /// ecouteur article selected
  Future<void> streamArticleSelected(
      String idCondition, String idArticle) async {
    _articleSelected = _firestoreService.streamDoc(
      path: FirestorePath.articleOfContidion(idCondition, idArticle),
      builder: (data, documentId) => ArticleSchema.fromMap(data, documentId),
    );
  }

  /// creer un article
  Future<void> addArticle(String value, String idCondition) async {
    final newArticle = ArticleSchema(title: value);

    await _firestoreService.add(
      path: FirestorePath.articlesOfCondition(idCondition),
      data: newArticle.toMap(),
    );
  }

  /// update title article
  Future<void> updateTitleArticle(
      String idCondition, String idArticle, String value) async {
    final updateArticle = ArticleSchema(title: value);
    await _firestoreService.update(
      path: FirestorePath.articleOfContidion(idCondition, idArticle),
      data: updateArticle.toMap(),
    );
  }

  /// suppression article
  Future<void> deleteArticle(String idCondition, String idArticle) async {
    final contentArticleProvider = ContentArticleState();

    /// suppression de tout les content de l'article
    await contentArticleProvider.deteleAllContent(idCondition, idArticle);

    await _firestoreService.delete(
      path: FirestorePath.articleOfContidion(idCondition, idArticle),
    );
  }

  /// delete tous les articles
  Future<void> deleteAllArticle(String idCondition) async {
    final contentArticleProvider = ContentArticleState();

    /// instance firestore
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref path
    CollectionReference contents = FirebaseFirestore.instance.collection(
      FirestorePath.articlesOfCondition(idCondition),
    );

    return contents.get().then((querySnapshot) async {
      for (var document in querySnapshot.docs) {
        /// suppression de tout les content de l'article
        await contentArticleProvider.deteleAllContent(idCondition, document.id);
        batch.delete(document.reference);
      }
      notifyListeners();

      return batch.commit();
    });
  }
}

/// state de la class ArticleState
final articleState =
    ChangeNotifierProvider<ArticleState>((ref) => ArticleState());

/// state de tous les article de la condition selectionné
final allArticleOfConditionStream = StreamProvider((ref) {
  ref.watch(conditionSelect).whenData((value) {
    ref.watch(articleState).streamArticles(value.id!);
  });
  return ref.watch(articleState).articlesOfCondition;
});

/// state de l'article selectionné
final articleSelectStream = StreamProvider((ref) {
  return ref.watch(articleState).articleSelected;
});
