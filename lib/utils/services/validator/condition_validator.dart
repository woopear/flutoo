class ConditionValidator {
  static String errorInputTitle = 'Veuillez entrer titre valide';

  /// validator input title condition
  static String? validatorInputTitle(String? value) {
    if (value == null || value.isEmpty) {
      return errorInputTitle;
    }
    return null;
  }
}
