import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ArticleProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<ArticleSchema>> articlesOfCondition;
  late Stream<ArticleSchema> articleSelected;

  /// ecouteur articles
  Future<void> streamArticles(String idCondition) async {
    articlesOfCondition = _firestoreService.streamCol(
      path: FirestorePath.articlesOfCondition(idCondition),
      builder: (data, documentId) => ArticleSchema.fromMap(data, documentId),
    );
  }

  /// ecouteur article selected
  Future<void> streamArticleSelected(
      String idCondition, String idArticle) async {
    articleSelected = _firestoreService.streamDoc(
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

  /// suppression article
  /// TODO: ATTENTION supprimer les collections enfants ou
  /// TODO: impossible de supprimer si il y a des collections enfants
  Future<void> deleteArticle(String idCondition, String idArticle) async {
    await _firestoreService.delete(
      path: FirestorePath.articleOfContidion(idCondition, idArticle),
    );
  }
}
