import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
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
}