import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/exceptions/http_exception.dart';
import 'package:shopping/screens/auth_screen.dart';

class Auth with ChangeNotifier {
  static const String _apiKey = 'AIzaSyD8crq5H-MKW2mXW0qLod8A-onTvsqmfzM';
  static const String _signInUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
  static const String _signUpUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';

  String _token = '';

  DateTime _tokenExpiryDate;

  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    if (this.token != null) {
      return true;
    }
    return false;
  }

  String get token {
    if (_tokenExpiryDate != null &&
        _tokenExpiryDate.isAfter(DateTime.now()) &&
        _token.isNotEmpty) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(
      {@required String email,
      @required String password,
      @required AuthMode authMode}) async {
    try {
      final respJson =
          await http.post(authMode == AuthMode.Signup ? _signUpUrl : _signInUrl,
              body: json.encode({
                'email': email,
                'password': password,
                'returnSecureToken': true,
              }));
      final resp = json.decode(respJson.body);
      if (resp['error'] != null) {
        throw HttpException(resp['error']['message']);
      }
      _token = resp['idToken'];
      _userId = resp['localId'];
      _tokenExpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(resp['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'userData',
          json.encode({
            'token': _token,
            'expiryTime': _tokenExpiryDate.toIso8601String(),
            'userId': _userId,
          }));
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<bool> tryLogin() async {
    print('Trying autologin');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final data = json.decode(
      prefs.getString('userData'),
    );
    final expiryTime = DateTime.parse(data['expiryTime']);
    if (expiryTime.isBefore(DateTime.now())) {
      return false;
    }
    this._token = data['token'];
    this._userId = data['userId'];
    this._tokenExpiryDate = expiryTime;
    notifyListeners();
    this._autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _tokenExpiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    final expirersIn = _tokenExpiryDate.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    _authTimer = Timer(Duration(seconds: expirersIn), this.logout);
  }
}
