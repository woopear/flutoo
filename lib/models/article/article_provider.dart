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

  /// creation d'un article + d'un content (vide ou pas)
  Future<void> addArticle(String idCondition, ArticleSchema data,
      List<TextEditingController> listText) async {
    /// creation article
    final article = await _firestoreService.add(
      path: FirestorePath.articlesOfCondition(idCondition),
      data: data.toMap(),
      merge: true,
    );

    /// creation des contents en meme temps que l'article
    ContentArticleProvider()
        .addContentArticle(article!.id, idCondition, listText);
  }
}
