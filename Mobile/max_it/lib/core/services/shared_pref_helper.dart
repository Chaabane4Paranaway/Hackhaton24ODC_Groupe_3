import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() => _instance;

  SharedPrefManager._internal();

  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> storePasskey(String passkey) async {
    final prefs = await _getInstance();
    prefs.setString("passkey", passkey);
    prefs.reload();
  }

  Future<String?> getPasskey() async {
    final prefs = await _getInstance();
    return prefs.getString("passkey");
  }

  Future<void> clearPasskey() async {
    final prefs = await _getInstance();
    prefs.clear();
  }
}
