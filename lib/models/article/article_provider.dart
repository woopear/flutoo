import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/content_article/content_article_provider.dart';
import 'package:flutter/widgets.dart';

class ArticleProvider extends ChangeNotifier {
  /// creation du map article
  Map<String, dynamic>? createArticle(String? title) {
    return {
      'title': title,
    };
  }

  /// ajout d'un article à une condition
  Future<void> addArticle(
      String? idCondition, String? title, List<TextEditingController?>? text) async {
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
