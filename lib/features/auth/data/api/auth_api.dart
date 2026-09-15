import 'dart:convert';
import 'package:e_commerce_app/core/utils/app_api.dart';
import 'package:e_commerce_app/core/utils/secure_storage.dart';
import 'package:e_commerce_app/core/utils/shared_preferences.dart';
import 'package:e_commerce_app/core/utils/user_hive_boxes.dart';
import 'package:e_commerce_app/features/auth/data/model/login_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/login_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/data/model/register_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/register_response_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthApi {
  final supabase = Supabase.instance.client;

  String _parseErrorMessage(http.Response response, String fallback) {
    try {
      final json = jsonDecode(response.body);
      if (json is Map) {
        final message = json['message'];
        if (message is List && message.isNotEmpty) {
          return message.join(', ');
        } else if (message is String && message.isNotEmpty) {
          return message;
        }
      }
    } catch (_) {}
    return '$fallback. Status code: ${response.statusCode}';
  }

  Future<ApiResult<RegisterResponseDto>> register(
    RegisterRequestDto registerRequestDto,
  ) async {
    final url = Uri.https(AppApi.baseUrl, AppApi.registerEndpoint);
    try {
      var response = await http.post(url, body: registerRequestDto.toJson());
      if (response.statusCode != 201) {
        return ApiError<RegisterResponseDto>(
          _parseErrorMessage(response, 'Failed to register'),
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      await FlutterSharedPreferences.instance.saveUserId(json['id'].toString());
      await UserHiveBoxes.openCurrentUserBoxes();
      return ApiSuccess<RegisterResponseDto>(
        RegisterResponseDto.fromJson(json),
      );
    } catch (e) {
      return ApiError<RegisterResponseDto>(e.toString());
    }
  }

  Future<ApiResult<LoginResponseDto>> login(
    LoginRequestDto loginRequestDto,
  ) async {
    final url = Uri.https(AppApi.baseUrl, AppApi.loginEndpoint);
    try {
      var response = await http.post(url, body: loginRequestDto.toJson());
      if (response.statusCode != 201) {
        return ApiError<LoginResponseDto>(
          _parseErrorMessage(response, 'Failed to login'),
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      await SecureStorage.saveAccessToken(json['access_token']);
      await SecureStorage.saveRefreshToken(json['refresh_token']);
      await FlutterSharedPreferences.instance.removeUserId();
      await saveLoggedInUserId(json['access_token']);
      await UserHiveBoxes.openCurrentUserBoxes();
      return ApiSuccess<LoginResponseDto>(LoginResponseDto.fromJson(json));
    } catch (e) {
      return ApiError<LoginResponseDto>(e.toString());
    }
  }

  Future<ApiResult<RefreshTokenResponseDto>> refreshToken(
    RefreshTokenRequestDto refreshTokenRequestDto,
  ) async {
    final url = Uri.https(AppApi.baseUrl, AppApi.refreshTokenEndpoint);
    try {
      var response = await http.post(
        url,
        body: refreshTokenRequestDto.toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        return ApiError<RefreshTokenResponseDto>(
          _parseErrorMessage(response, 'Failed to refresh token'),
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      final refreshTokenResponse = RefreshTokenResponseDto.fromJson(json);
      if (refreshTokenResponse.accessToken != null) {
        await SecureStorage.saveAccessToken(refreshTokenResponse.accessToken!);
      }
      if (refreshTokenResponse.refreshToken != null) {
        await SecureStorage.saveRefreshToken(
          refreshTokenResponse.refreshToken!,
        );
      }
      await FlutterSharedPreferences.instance.removeUserId();
      if (refreshTokenResponse.accessToken != null) {
        await saveLoggedInUserId(refreshTokenResponse.accessToken!);
      }
      await UserHiveBoxes.openCurrentUserBoxes();
      return ApiSuccess<RefreshTokenResponseDto>(refreshTokenResponse);
    } catch (e) {
      return ApiError<RefreshTokenResponseDto>(e.toString());
    }
  }

  Future<ApiResult<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto resetPasswordRequestDto,
  ) async {
    final userId = await FlutterSharedPreferences.instance.getUserId();
    final url = Uri.https(
      AppApi.baseUrl,
      AppApi.resetPasswordEndpoint + userId,
    );
    try {
      var response = await http.put(
        url,
        body: resetPasswordRequestDto.toJson(),
      );
      if (response.statusCode != 200) {
        return ApiError<ResetPasswordResponseDto>(
          _parseErrorMessage(response, 'Failed to reset password'),
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      return ApiSuccess<ResetPasswordResponseDto>(
        ResetPasswordResponseDto.fromJson(json),
      );
    } catch (e) {
      return ApiError<ResetPasswordResponseDto>(e.toString());
    }
  }

  Future<void> sendOtpForNewUser(String email) async {
    try {
      await supabase.auth.signInWithOtp(email: email, shouldCreateUser: true);
    } catch (e) {
      throw 'Error from send OTP for new user: $e';
    }
  }

  Future<void> sendOtpForExistingUser(String email) async {
    try {
      await supabase.auth.signInWithOtp(email: email, shouldCreateUser: false);
    } catch (e) {
      throw 'Error from send OTP for existing user: $e';
    }
  }

  Future<bool> validateOtp({required String email, required String otp}) async {
    try {
      final result = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: otp,
      );
      return result.session != null;
    } catch (e) {
      throw 'Error from validate OTP: $e';
    }
  }

  Future<void> saveLoggedInUserId(String accessToken) async {
    try {
      final url = Uri.https(AppApi.baseUrl, AppApi.profileEndpoint);
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode != 200) return;

      final json = jsonDecode(response.body);
      final userId = json['id'];
      if (userId != null) {
        await FlutterSharedPreferences.instance.saveUserId(userId.toString());
      }
    } catch (_) {
      return;
    }
  }
}
