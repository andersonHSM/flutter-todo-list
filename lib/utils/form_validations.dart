class FormValidators {
  static String requiredFieldValidator(String value) {
    if (value.trim().length == 0) {
      return 'Required field';
    }
    return null;
  }

  static String passwordsMatchValidator(
      String password, String confirmPassword) {
    if (password.trim() != confirmPassword.trim()) {
      return 'Passwords must match';
    }
    return null;
  }
}
