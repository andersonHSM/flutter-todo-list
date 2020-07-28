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

  static String weakPasswordValidator(String value) {
    if (value.trim().length < 6) {
      return 'Password must be at leat 6 characacters';
    }
    return null;
  }
}
