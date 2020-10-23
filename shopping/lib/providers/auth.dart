import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/screens/auth_screen.dart';
import 'package:shopping/exceptions/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _tokenExpiryDate;
  String _userId;

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

  static const String _apiKey = 'AIzaSyD8crq5H-MKW2mXW0qLod8A-onTvsqmfzM';
  static const String _signInUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey';
  static const String _signUpUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey';

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
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
