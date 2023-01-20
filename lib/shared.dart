import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  void saveFirst() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirst', true);
  }

  Future<bool?> getFirst() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirst');
  }
}
