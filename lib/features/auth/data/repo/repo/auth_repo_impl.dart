import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/data_source/auth_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);

  @override
  Future<ApiResult<LoginResponseEntity>> login(
    LoginRequestEntity loginRequestEntity,
  ) async {
    return await _authDataSource.login(loginRequestEntity);
  }

  @override
  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestEntity registerRequestEntity,
  ) async {
    return await _authDataSource.register(registerRequestEntity);
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity resetPasswordRequestEntity,
  ) async {
    return await _authDataSource.resetPassword(resetPasswordRequestEntity);
  }

  @override
  Future<void> sendOtpForExistingUser(String email) async {
    return await _authDataSource.sendOtpForExistingUser(email);
  }

  @override
  Future<void> sendOtpForNewUser(String email) async {
    return await _authDataSource.sendOtpForNewUser(email);
  }

  @override
  Future<bool> validateOtp({required String email, required String otp}) async {
    return await _authDataSource.validateOtp(email: email, otp: otp);
  }
}
