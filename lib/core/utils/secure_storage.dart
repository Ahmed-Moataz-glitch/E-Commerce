import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static final flutterSecureStorage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await flutterSecureStorage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await flutterSecureStorage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await flutterSecureStorage.delete(key: 'token');
  }
}
