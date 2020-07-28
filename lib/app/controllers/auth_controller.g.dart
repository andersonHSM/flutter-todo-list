// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  Computed<String> _$tokenComputed;

  @override
  String get token => (_$tokenComputed ??=
          Computed<String>(() => super.token, name: '_AuthController.token'))
      .value;
  Computed<String> _$userIdComputed;

  @override
  String get userId => (_$userIdComputed ??=
          Computed<String>(() => super.userId, name: '_AuthController.userId'))
      .value;
  Computed<bool> _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_AuthController.isAuthenticated'))
          .value;

  final _$_tokenAtom = Atom(name: '_AuthController._token');

  @override
  String get _token {
    _$_tokenAtom.reportRead();
    return super._token;
  }

  @override
  set _token(String value) {
    _$_tokenAtom.reportWrite(value, super._token, () {
      super._token = value;
    });
  }

  final _$_userIdAtom = Atom(name: '_AuthController._userId');

  @override
  String get _userId {
    _$_userIdAtom.reportRead();
    return super._userId;
  }

  @override
  set _userId(String value) {
    _$_userIdAtom.reportWrite(value, super._userId, () {
      super._userId = value;
    });
  }

  final _$_expireDateAtom = Atom(name: '_AuthController._expireDate');

  @override
  DateTime get _expireDate {
    _$_expireDateAtom.reportRead();
    return super._expireDate;
  }

  @override
  set _expireDate(DateTime value) {
    _$_expireDateAtom.reportWrite(value, super._expireDate, () {
      super._expireDate = value;
    });
  }

  final _$_logoutTimerAtom = Atom(name: '_AuthController._logoutTimer');

  @override
  Timer get _logoutTimer {
    _$_logoutTimerAtom.reportRead();
    return super._logoutTimer;
  }

  @override
  set _logoutTimer(Timer value) {
    _$_logoutTimerAtom.reportWrite(value, super._logoutTimer, () {
      super._logoutTimer = value;
    });
  }

  final _$_authenticateAsyncAction =
      AsyncAction('_AuthController._authenticate');

  @override
  Future<void> _authenticate(String email, String password, String url) {
    return _$_authenticateAsyncAction
        .run(() => super._authenticate(email, password, url));
  }

  final _$tryAutoLoginAsyncAction = AsyncAction('_AuthController.tryAutoLogin');

  @override
  Future<void> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  final _$signupAsyncAction = AsyncAction('_AuthController.signup');

  @override
  Future<void> signup(String email, String password) {
    return _$signupAsyncAction.run(() => super.signup(email, password));
  }

  final _$signinAsyncAction = AsyncAction('_AuthController.signin');

  @override
  Future<void> signin(String email, String password) {
    return _$signinAsyncAction.run(() => super.signin(email, password));
  }

  final _$_AuthControllerActionController =
      ActionController(name: '_AuthController');

  @override
  void logout() {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.logout');
    try {
      return super.logout();
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _autoLogout() {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController._autoLogout');
    try {
      return super._autoLogout();
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
userId: ${userId},
isAuthenticated: ${isAuthenticated}
    ''';
  }
}
