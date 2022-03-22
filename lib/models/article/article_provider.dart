import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
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
    final contentArticleProvider = ContentArticleProvider();

    /// suppression de tout les content de l'article
    await contentArticleProvider.deteleAllContent(idCondition, idArticle);

    await _firestoreService.delete(
      path: FirestorePath.articleOfContidion(idCondition, idArticle),
    );
  }

  /// delete tous les articles
  Future<void> deleteAllArticle(String idCondition) async {
    final contentArticleProvider = ContentArticleProvider();

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
