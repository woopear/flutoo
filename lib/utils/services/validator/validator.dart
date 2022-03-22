class Validator {
  static String inputTodoText = "Veuillez entrer une tâche valide";
  static String inputConditionTitle = "Veuillez entrer un titre valide";
  static String inputArticleTitle = "Veuillez entrer un titre valide";

  /// validator pour les input text basic
  /// test si null ou si isEmpty
  static validatorInputTextBasic({String? textError, String? value}) {
    if (value == null || value.isEmpty) {
      return textError;
    }
    return null;
  }
}
