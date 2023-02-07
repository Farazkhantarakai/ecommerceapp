import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _tokenId = '';
  DateTime? _expireDate;
  String _userId = '';
  Timer? _timer;

  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_expireDate != null &&
        _tokenId.isNotEmpty &&
        _expireDate!.isAfter(DateTime.now())) {
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
        autoLogOut();
        notifyListeners();
        SharedPreferences spf = await SharedPreferences.getInstance();
        final user = json.encode({
          'token': _tokenId,
          'expiryDate': _expireDate!.toIso8601String(),
          'userId': _userId
        });
        spf.setString('userData', user);
      }
    } catch (err) {
      rethrow;
    }
  }

  signUpUser(String email, String password) {
    return authenticate(email, password, 'signUp');
  }

  logInUser(String email, String password) {
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<bool>? tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    if (expiryDate.isBefore((DateTime.now()))) {
      return false;
    }
    _tokenId = extractedData['token'];
    _userId = extractedData['userId'];
    _expireDate = expiryDate;
    notifyListeners();
    autoLogOut();
    return true;
  }

  logOut() {
    _tokenId = '';
    _expireDate = null;
    _userId = '';
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  autoLogOut() {
    //if timer is not null then cancel it
    if (_timer != null) {
      _timer!.cancel();
    }
    //this will give the remaining time when the time will expire
    final timeToExpire = _expireDate!.difference(DateTime.now()).inSeconds;
    //this is taking two argument
    _timer = Timer(Duration(seconds: timeToExpire), logOut);
  }
}
