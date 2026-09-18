import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/refresh_token_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_existing_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_new_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/validate_otp_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SendOtpForNewUserUseCase sendOtpForNewUserUseCase;
  final SendOtpForExistingUserUseCase sendOtpForExistingUserUseCase;
  final ValidateOtpUseCase validateOtpUseCase;
  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.refreshTokenUseCase,
    required this.resetPasswordUseCase,
    required this.sendOtpForNewUserUseCase,
    required this.sendOtpForExistingUserUseCase,
    required this.validateOtpUseCase,
  }) : super(AuthInitial());

  Future<void> register(RegisterRequestEntity registerRequestEntity) async {
    emit(RegisterLoading());
    final result = await registerUseCase.call(registerRequestEntity);
    switch (result) {
      case ApiSuccess<RegisterResponseEntity>():
        emit(RegisterSuccess());
        break;
      case ApiError<RegisterResponseEntity>():
        emit(RegisterError(result.message));
        break;
    }
  }

  Future<void> login(LoginRequestEntity loginRequestEntity) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(loginRequestEntity);
    switch (result) {
      case ApiSuccess<LoginResponseEntity>():
        emit(LoginSuccess());
        break;
      case ApiError<LoginResponseEntity>():
        emit(LoginError(result.message));
        break;
    }
  }

  Future<void> refreshToken(
    RefreshTokenRequestEntity refreshTokenRequestEntity,
  ) async {
    emit(RefreshTokenLoading());
    final result = await refreshTokenUseCase.call(refreshTokenRequestEntity);
    switch (result) {
      case ApiSuccess<RefreshTokenResponseEntity>():
        emit(RefreshTokenSuccess());
        break;
      case ApiError<RefreshTokenResponseEntity>():
        emit(RefreshTokenError(result.message));
        break;
    }
  }

  Future<void> resetPassword(
    ResetPasswordRequestEntity resetPasswordRequestEntity,
  ) async {
    emit(ResetPasswordLoading());
    final result = await resetPasswordUseCase.call(resetPasswordRequestEntity);
    switch (result) {
      case ApiSuccess<ResetPasswordResponseEntity>():
        emit(ResetPasswordSuccess());
        break;
      case ApiError<ResetPasswordResponseEntity>():
        emit(ResetPasswordError(result.message));
        break;
    }
  }

  Future<void> sendOtpForNewUser(String email) async {
    emit(SendingOtp());
    try {
      await sendOtpForNewUserUseCase.call(email);
      emit(OtpSent('OTP sent successfully'));
    } catch (e) {
      emit(SendingOtpError(e.toString()));
    }
  }

  Future<void> resendOtpForNewUser(String email) async {
    emit(ReSendingOtp());
    try {
      await sendOtpForNewUserUseCase.call(email);
      emit(OtpReSent('OTP resent successfully'));
    } catch (e) {
      emit(ReSendingOtpError(e.toString()));
    }
  }

  Future<void> sendOtpForExistingUser(String email) async {
    emit(SendingOtp());
    try {
      await sendOtpForExistingUserUseCase.call(email);
      emit(OtpSent('OTP sent successfully'));
    } catch (e) {
      emit(SendingOtpError(e.toString()));
    }
  }

  Future<void> validateOtp({required String email, required String otp}) async {
    emit(VerifyingOtp());
    try {
      final result = await validateOtpUseCase.call(email: email, otp: otp);
      switch (result) {
        case true:
          emit(OtpVerified());
        case false:
          emit(VerifyingOtpError('Invalid OTP'));
      }
    } catch (e) {
      emit(VerifyingOtpError(e.toString()));
    }
  }
}
