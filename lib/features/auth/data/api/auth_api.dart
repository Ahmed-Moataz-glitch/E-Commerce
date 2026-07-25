import 'dart:convert';
import 'package:e_commerce_app/core/utils/app_api.dart';
import 'package:e_commerce_app/core/utils/secure_storage.dart';
import 'package:e_commerce_app/core/utils/shared_preferences.dart';
import 'package:e_commerce_app/features/auth/data/model/login_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/login_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/data/model/register_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/register_response_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthApi {
  final supabase = Supabase.instance.client;

  Future<ApiResult<RegisterResponseDto>> register(
    RegisterRequestDto registerRequestDto,
  ) async {
    final url = Uri.https(AppApi.baseUrl, AppApi.registerEndpoint);
    try {
      var response = await http.post(url, body: registerRequestDto.toJson());
      if (response.statusCode != 201) {
        return ApiError<RegisterResponseDto>(
          'Failed to register. Status code: ${response.statusCode}',
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      await FlutterSharedPreferences.instance.saveUserId(json['id'].toString());
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
          'Failed to login. Status code: ${response.statusCode}',
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      await SecureStorage.saveToken(json['access_token']);
      return ApiSuccess<LoginResponseDto>(
        LoginResponseDto.fromJson(json),
      );
    } catch (e) {
      return ApiError<LoginResponseDto>(e.toString());
    }
  }

  Future<ApiResult<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto resetPasswordRequestDto,
  ) async {
    final userId = await FlutterSharedPreferences.instance.getUserId();
    final url = Uri.https(AppApi.baseUrl, AppApi.resetPasswordEndpoint + userId);
    try {
      var response = await http.put(url, body: resetPasswordRequestDto.toJson());
      if (response.statusCode != 200) {
        return ApiError<ResetPasswordResponseDto>(
          'Failed to reset password. Status code: ${response.statusCode}',
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
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
      );
    } catch (e) {
      throw 'Error from send OTP for new user: $e';
    }
  }

  Future<void> sendOtpForExistingUser(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: false,
      );
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
}
