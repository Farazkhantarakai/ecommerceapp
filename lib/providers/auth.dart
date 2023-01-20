import 'dart:convert';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _tokenId = '';
  DateTime? _expireDate;
  String _userId = '';

  bool get isAuth {
    // if (kDebugMode) {
    //   print('token $token');
    // }
    return token != '';
  }

  String get token {
    if (_expireDate != null &&
        _tokenId.isNotEmpty &&
        _expireDate!.isAfter(DateTime.now())) {
      // if (kDebugMode) {
      //   print('token receieved $_tokenId');
      // }
      return _tokenId;
    }
    return '';
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA0RugQmmuyVMaBcRb4gtun_zhasblGrKc';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body.toString());
        if (result['error'] != null) {
          throw HttpException(result['error']['message']);
        }
        _tokenId = result['idToken'];
        _expireDate = DateTime.now()
            .add(Duration(seconds: int.parse(result['expiresIn'])));
        _userId = result['localId'];
        notifyListeners();
      }
    } catch (err) {
      throw err;
    }
  }

  signUpUser(String email, String password) {
    return authenticate(email, password, 'signUp');
  }

  logInUser(String email, String password) {
    return authenticate(email, password, 'signInWithPassword');
  }
}
