import 'package:shared_preferences/shared_preferences.dart';

class SavePersonData {
  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') ?? '';
  }

  static Future<void> setUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', DateTime.now().microsecond.toString());
  }
}
