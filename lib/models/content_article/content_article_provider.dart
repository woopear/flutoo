import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ContentArticleProvider extends ChangeNotifier {
  /// creation du map contentarticle
  Map<String, dynamic>? createContentArticle(String? text) {
    return {
      'text': text,
    };
  }

  /// ajout d'un article à une condition
  Future<void> addContentArticle(String? idCondition, String? idArticle, String? text) async {
    CollectionReference contentArticleApi = FirebaseFirestore.instance
        .collection('conditions/$idCondition/articles/$idArticle/contents');

    await contentArticleApi.add(createContentArticle(text));
  }
}