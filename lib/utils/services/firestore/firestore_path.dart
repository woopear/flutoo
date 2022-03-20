/// contien toute les fonctions
/// qui retourne les routes d'accès
/// au data des différents model
class FirestorePath {
  /// routes todo
  static String todo(String id) => 'todos/$id';
  static String todos() => 'todos';

  /// routes condition
  static String conditions() => 'conditions';
  static String condition(String id) => 'conditions/$id';

  /// routes article
  static String articlesOfCondition(String idCondition) =>
      'conditions/$idCondition/articles';
}
