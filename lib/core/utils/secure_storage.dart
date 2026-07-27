import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static final flutterSecureStorage = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await flutterSecureStorage.write(key: 'access-token', value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await flutterSecureStorage.write(key: 'refresh-token', value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await flutterSecureStorage.read(key: 'refresh-token');
  }

  static Future<String?> getAccessToken() async {
    return await flutterSecureStorage.read(key: 'access-token');
  }

  static Future<String?> getToken() async {
    final accessToken = await flutterSecureStorage.read(key: 'access-token');
    final refreshToken = await flutterSecureStorage.read(key: 'refresh-token');
    return accessToken ?? refreshToken;
  }
}
