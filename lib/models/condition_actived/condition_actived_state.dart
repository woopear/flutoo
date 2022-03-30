import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/content_article/content_article_schema.dart';
import 'package:flutoo/utils/services/firestore/firestore_path.dart';
import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class ConditionActivedState extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;

  late Stream<List<ConditionSchema>> _conditions;
  late Stream<List<ArticleSchema>> _articles;
  late Stream<List<ContentArticleSchema>> _contents;

  Stream<List<ConditionSchema>> get conditions => _conditions;
  Stream<List<ArticleSchema>> get articles => _articles;
  Stream<List<ContentArticleSchema>> get contents => _contents;

  /// ecoute condition activate
  Future<void> streamConditions() async {
    _conditions = _firestoreService.streamCol(
      path: FirestorePath.conditions(),
      builder: (data, documentId) => ConditionSchema.formMap(data, documentId),
      queryBuilder: (query) => query.where('activate', isEqualTo: true),
    );
  }

  /// ecoute les article de la condition activate
  Future<void> streamArticles(String idCondition) async {
    _articles = _firestoreService.streamCol(
      path: FirestorePath.articlesOfCondition(idCondition),
      builder: (data, documentId) => ArticleSchema.fromMap(data, documentId),
    );
  }

  /// ecoute les contents de l'article en cours
  Future<void> streamContents(String idCondition, String idArticle) async {
    _contents = _firestoreService.streamCol(
      path: FirestorePath.contentsOfArticle(idCondition, idArticle),
      builder: (data, documentId) =>
          ContentArticleSchema.fromMap(data, documentId),
    );
  }

  Future<List<ContentArticleSchema>> futureContents(
      String idCondition, String idArticle) async {
    return await _firestoreService.getCol(
      path: FirestorePath.contentsOfArticle(idCondition, idArticle),
      builder: (data, documentId) =>
          ContentArticleSchema.fromMap(data, documentId),
    );
  }
}

/// state de la class condition activate state
final conditionActivedState = ChangeNotifierProvider<ConditionActivedState>(
    (ref) => ConditionActivedState());

/// state condition actived
final conditionActivateStream = StreamProvider((ref) {
  ref.watch(conditionActivedState).streamConditions();
  return ref.watch(conditionActivedState).conditions;
});

/// state des articles de la condition activate
final articlesOfConditionStream = StreamProvider.autoDispose((ref) {
  return ref.read(conditionActivedState).articles;
});

/// future qui recupere les contens en fonction 
/// de l'idCondition et de l'idArticle
final contentsFuture = FutureProvider.family((ref, Tuple2 t) async {
  final f =
      await ref.watch(conditionActivedState).futureContents(t.item1, t.item2);
  return f;
});