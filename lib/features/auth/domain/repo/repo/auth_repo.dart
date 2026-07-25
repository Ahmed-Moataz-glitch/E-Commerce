import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';

abstract class AuthRepo {
  Future<ApiResult<RegisterResponseEntity>> register(
    RegisterRequestEntity registerRequestEntity,
  );

  Future<ApiResult<LoginResponseEntity>> login(LoginRequestEntity loginRequestEntity);

  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity resetPasswordRequestEntity,
  );

  Future<void> sendOtpForNewUser(String email);

  Future<void> sendOtpForExistingUser(String email);

  Future<bool> validateOtp({required String email, required String otp});
}