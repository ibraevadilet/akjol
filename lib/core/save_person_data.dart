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

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Role') ?? '';
  }

  static Future<void> setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Role', role);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
