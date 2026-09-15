import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/shared_preferences.dart';
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/data/api/auth_api.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_response_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class SecureStorage {
  static final AuthApi authApi = AuthApi();
  static final flutterSecureStorage = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await flutterSecureStorage.write(key: AppConstants.accessTokenKey, value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await flutterSecureStorage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await flutterSecureStorage.read(key: AppConstants.refreshTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return await flutterSecureStorage.read(key: AppConstants.accessTokenKey);
  }

  static Future<void> clearTokens() async {
    await flutterSecureStorage.delete(key: AppConstants.accessTokenKey);
    await flutterSecureStorage.delete(key: AppConstants.refreshTokenKey);
    await FlutterSharedPreferences.instance.removeUserId();
  }

  static Future<String?> getToken() async {
    final accessToken = await getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      final expiresAt = JwtDecoder.getExpirationDate(accessToken);
      if (expiresAt.isAfter(DateTime.now())) {
        return accessToken;
      }
    }

    final refreshToken = await getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    final result = await authApi.refreshToken(
      RefreshTokenRequestDto(refreshToken: refreshToken),
    );

    if (result is ApiSuccess<RefreshTokenResponseDto>) {
      return result.data?.accessToken;
    }

    return null;
  }
}
