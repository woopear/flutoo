import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ArticleProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;

  /// creer un article
  Future<void> addArticle(String value, String idCondition) async {
    final newArticle = ArticleSchema(title: value);

    await _firestoreService.add(
      path: FirestorePath.articlesOfCondition(idCondition),
      data: newArticle.toMap(),
    );
  }
}
