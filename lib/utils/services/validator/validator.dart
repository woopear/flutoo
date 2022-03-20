class Validator {
  static String titleArticle = 'Veuillez entrer un titre valide';
  static String titleCondition = 'Veuillez entrer un titre valide';

  /// validator pour les input text basic
  /// test si null ou si isEmpty
  static validatorInputTextBasic({String? textError, String? value}) {
    if (value == null || value.isEmpty) {
      return textError;
    }
    return null;
  }
}
