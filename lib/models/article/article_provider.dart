import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ArticleProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  late Stream<List<ArticleSchema>> articles;

  /// ecouteur collection article de la condition selectionné
  Future<void> streamArticles(String idCondition) async {
    articles = _firestoreService.streamCol(
      path: FirestorePath.articlesOfCondition(idCondition),
      builder: (data, documentId) => ArticleSchema.fromMap(data, documentId),
    );
  }

  /// * test en cours

  /// ecouteur collection conditions
  Stream<QuerySnapshot>? listenArticlesConition(String? idCondition) {
    return FirebaseFirestore.instance
        .collection('conditions/$idCondition/articles')
        .snapshots();
  }

  /// creation du map article
  Map<String, dynamic>? createArticle(String? title) {
    return {
      'title': title,
    };
  }

  /// ajout d'un article à une condition
  Future<void> addArticle(String? idCondition, String? title,
      List<TextEditingController?>? text) async {
    /// creation instance collection article
    CollectionReference articleApi = FirebaseFirestore.instance
        .collection('conditions/$idCondition/articles');

    /// ajout creation de l'article
    final article = await articleApi.add(createArticle(title));
    print(article.id);

    /// ajout creation du content de l'article creer précédement
    for (var element in text!) {
      await ContentArticleProvider()
          .addContentArticle(idCondition, article.id, element!.text);
    }
  }
}
