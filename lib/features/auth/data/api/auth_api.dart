import 'dart:convert';

import 'package:e_commerce_app/core/utils/app_api.dart';
import 'package:e_commerce_app/features/auth/data/model/login_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/login_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/data/model/register_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/register_response_dto.dart';

class AuthApi {
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
      return ApiSuccess<LoginResponseDto>(
        LoginResponseDto.fromJson(json),
      );
    } catch (e) {
      return ApiError<LoginResponseDto>(e.toString());
    }
  }
}
