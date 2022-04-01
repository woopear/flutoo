/// * contien toute les fonctions
/// * qui retourne les routes d'accès
/// * au data des différents model

class FirestorePath {
  /// routes todo
  static String todos() => 'todos';
  static String todo(String idTodo) => 'todos/$idTodo';

  /// routes condition
  static String conditions() => 'conditions';
  static String condition(String idCondition) => 'conditions/$idCondition';

  /// routes article
  static String articlesOfCondition(String idCondition) =>
      'conditions/$idCondition/articles';
  static String articleOfContidion(String idCondition, String idArticle) =>
      'conditions/$idCondition/articles/$idArticle';

  /// route content
  static String contentsOfArticle(String idCondition, String idArticle) =>
      'conditions/$idCondition/articles/$idArticle/contents';
  static String contentOfArticle(
          String idCondition, String idArticle, String idContent) =>
      'conditions/$idCondition/articles/$idArticle/contents/$idContent';

  /// route user
  static String usersCollection() => 'users';
  static String userCollection(String idUser) => 'users/$idUser';
}
