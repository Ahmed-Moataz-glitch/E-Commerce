part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}

final class SendingOtp extends AuthState {}

final class OtpSent extends AuthState {
  final String message;

  OtpSent(this.message);
}

final class SendingOtpError extends AuthState {
  final String message;

  SendingOtpError(this.message);
}

final class ReSendingOtp extends AuthState {}

final class OtpReSent extends AuthState {
  final String message;

  OtpReSent(this.message);
}

final class ReSendingOtpError extends AuthState {
  final String message;

  ReSendingOtpError(this.message);
}

final class VerifyingOtp extends AuthState {}

final class OtpVerified extends AuthState {}

final class VerifyingOtpError extends AuthState {
  final String message;

  VerifyingOtpError(this.message);
}

final class RefreshTokenSuccess extends AuthState {}

final class RefreshTokenError extends AuthState {
  final String message;
  RefreshTokenError(this.message);
}
