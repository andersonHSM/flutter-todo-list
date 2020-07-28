import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:todo/app/data/shared_preferencees_store.dart';
import 'package:todo/exceptions/auth_exception.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  static Dio dio = Dio();

  static const _apiKey = 'AIzaSyAjm3EGiq163XN6GNEr_F-9hVzuS2gnSEU';
  static const _signupUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
  static const _signInUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";

  @observable
  String _token;

  @observable
  String _userId;

  @observable
  DateTime _expireDate;

  @observable
  Timer _logoutTimer;

  @computed
  String get token {
    if (_token != null &&
        _expireDate != null &&
        _expireDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  @computed
  String get userId {
    return isAuthenticated ? _userId : null;
  }

  @computed
  bool get isAuthenticated {
    return token != null;
  }

  @action
  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await dio.post(
        url,
        data: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseBody = response.data;

      _token = responseBody['idToken'];
      _expireDate = DateTime.now().add(
        Duration(seconds: int.parse(responseBody['expiresIn'])),
      );
      _userId = responseBody['localId'];

      await SharedPreferenceStore.saveMap('userData', {
        "token": _token,
        "userId": _userId,
        "expireDate": _expireDate.toIso8601String(),
      });

      _autoLogout();

      return Future.value();
    } on DioError catch (e) {
      throw AuthException(e.response.data['error']['message']);
    }
  }

  @action
  Future<void> tryAutoLogin() async {
    if (isAuthenticated) {
      return Future.value();
    }

    final userData = await SharedPreferenceStore.getMap('userData');

    if (userData == null) {
      return Future.value();
    }

    final expireDate = DateTime.parse(userData['expireDate']);

    if (expireDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _userId = userData['userId'];
    _token = userData['token'];
    _expireDate = expireDate;

    _autoLogout();

    return Future.value();
  }

  @action
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "$_signupUrl$_apiKey");
  }

  @action
  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, "$_signInUrl$_apiKey");
  }

  @action
  void logout() {
    _token = null;
    _expireDate = null;
    _userId = null;

    SharedPreferenceStore.remove('userData');
  }

  @action
  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }
    final int timeToLogout = _expireDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}
