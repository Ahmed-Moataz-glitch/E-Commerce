import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class LoginUseCase {
  final AuthRepo _authRepo;
  LoginUseCase(this._authRepo);

  Future<ApiResult<LoginResponseEntity>> call(
    LoginRequestEntity loginRequestEntity,
  ) {
    return _authRepo.login(loginRequestEntity);
  }
}
