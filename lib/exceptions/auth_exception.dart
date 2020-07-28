class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_NOT_FOUND': 'Credenciais inválidas',
    'INVALID_PASSWORD': 'Credenciais inválidas',
    'USER_DISABLED': 'Usuário desabilitado',
    'EMAIL_EXISTS': 'E-mail já cadastrado',
    "OPERATION_NOT_ALLOWED": "Operação não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tentativas excedidas"
  };
  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    }

    return "Ocorreu um erro na autenticação";
  }
}
