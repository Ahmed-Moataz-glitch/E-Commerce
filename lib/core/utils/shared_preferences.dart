import 'package:shared_preferences/shared_preferences.dart';

class FlutterSharedPreferences {
  FlutterSharedPreferences._();
  static final FlutterSharedPreferences instance = FlutterSharedPreferences._();
  static final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  final userIdKey = 'userId';

  Future<SharedPreferences> get() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await _sharedPreferences;
    prefs.setString(userIdKey, userId);
  }

  Future<String> getUserId() async {
    final prefs = await _sharedPreferences;
    return prefs.getString(userIdKey) ?? '';
  }

  Future<void> removeUserId() async {
    final prefs = await _sharedPreferences;
    await prefs.remove(userIdKey);
  }
}
