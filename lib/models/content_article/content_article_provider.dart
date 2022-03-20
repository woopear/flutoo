import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/content_article/content_article_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ContentArticleProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  Stream<QuerySnapshot>? contents;

  /// creation du map contentarticle
  Map<String, dynamic>? createContentArticle(String? text) {
    return {
      'text': text,
    };
  }

  /// ecoute content d'un article
  void listenContentArticlesConition(String? idArticle, String? idCondition) {
    contents = FirebaseFirestore.instance
        .collection('conditions/$idCondition/articles/$idArticle/contents')
        .snapshots();
  }

  /// ajout d'un article à une condition
  Future<void> addContentArticle(
    String? idArticle,
    String? idCondition,
    List<TextEditingController> listText,
  ) async {
    /// creation content de l'article
    for (TextEditingController text in listText){
      final content = ContentArticleSchema(text: text.text);
      await _firestoreService.add(
        path: FirestorePath.contentsArticle(idArticle!, idCondition!),
        data: content.toMap(),
      );
    }
  }
}
