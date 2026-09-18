import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/data/api/auth_api.dart';
import 'package:e_commerce_app/features/auth/data/model/login_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/login_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/register_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/register_response_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/reset_password_response_dto.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/data_source/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final AuthApi _authApi;
  AuthDataSourceImpl(this._authApi);

  @override
  Future<ApiResult<LoginResponseEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    final result = await _authApi.login(
      LoginRequestDto(
        email: loginRequestEntity.email,
        password: loginRequestEntity.password,
      ),
    );
    switch (result) {
      case ApiSuccess<LoginResponseDto>():
        return ApiSuccess<LoginResponseEntity>(result.data?.toEntity());
      case ApiError<LoginResponseDto>():
        return ApiError<LoginResponseEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<RefreshTokenResponseEntity>> refreshToken(
    RefreshTokenRequestEntity refreshTokenRequestEntity,
  ) async {
    final result = await _authApi.refreshToken(
      RefreshTokenRequestDto(
        refreshToken: refreshTokenRequestEntity.refreshToken,
      ),
    );
    switch (result) {
      case ApiSuccess<RefreshTokenResponseDto>():
        return ApiSuccess<RefreshTokenResponseEntity>(result.data?.toEntity());
      case ApiError<RefreshTokenResponseDto>():
        return ApiError<RefreshTokenResponseEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestEntity registerRequestEntity,
  ) async {
    final result = await _authApi.register(
      RegisterRequestDto(
        email: registerRequestEntity.email,
        password: registerRequestEntity.password,
        name: registerRequestEntity.name,
        avatar: registerRequestEntity.avatar.isNotEmpty
            ? registerRequestEntity.avatar
            : 'https://api.lorem.space/image/face?w=640&h=480',
      ),
    );
    switch (result) {
      case ApiSuccess<RegisterResponseDto>():
        return ApiSuccess<RegisterResponseEntity>(result.data?.toEntity());
      case ApiError<RegisterResponseDto>():
        return ApiError<RegisterResponseEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(ResetPasswordRequestEntity resetPasswordRequestEntity) async {
    final result = await _authApi.resetPassword(
      ResetPasswordRequestDto(
        password: resetPasswordRequestEntity.password,
      ),
    );
    switch (result) {
      case ApiSuccess<ResetPasswordResponseDto>():
        return ApiSuccess<ResetPasswordResponseEntity>(result.data?.toEntity());
      case ApiError<ResetPasswordResponseDto>():
        return ApiError<ResetPasswordResponseEntity>(result.message);
    }
  }
  
  @override
  Future<void> sendOtpForExistingUser(String email) async {
    return await _authApi.sendOtpForExistingUser(email);
  }
  
  @override
  Future<void> sendOtpForNewUser(String email) async {
    return await _authApi.sendOtpForNewUser(email);
  }
  
  @override
  Future<bool> validateOtp({required String email, required String otp}) async {
    return await _authApi.validateOtp(email: email, otp: otp);
  }
}
