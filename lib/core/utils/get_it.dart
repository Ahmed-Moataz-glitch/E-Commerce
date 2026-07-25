import 'package:e_commerce_app/features/auth/data/api/auth_api.dart';
import 'package:e_commerce_app/features/auth/data/repo/data_source/auth_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/data/repo/repo/auth_repo_impl.dart';
import 'package:e_commerce_app/features/auth/domain/repo/data_source/auth_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_existing_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_new_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/validate_otp_use_case.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerSingleton<AuthDataSource>(AuthDataSourceImpl(getIt<AuthApi>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt<AuthDataSource>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<SendOtpForExistingUserUseCase>(
    SendOtpForExistingUserUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<SendOtpForNewUserUseCase>(
    SendOtpForNewUserUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ValidateOtpUseCase>(
    ValidateOtpUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      registerUseCase: getIt<RegisterUseCase>(),
      loginUseCase: getIt<LoginUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      sendOtpForNewUserUseCase: getIt<SendOtpForNewUserUseCase>(),
      sendOtpForExistingUserUseCase: getIt<SendOtpForExistingUserUseCase>(),
      validateOtpUseCase: getIt<ValidateOtpUseCase>(),
    ),
  );
}
