import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class RegisterUseCase {
  final AuthRepo _authRepo;
  RegisterUseCase(this._authRepo);

  Future<ApiResult<RegisterResponseEntity>> call(
    RegisterRequestEntity registerRequestEntity,
  ) {
    return _authRepo.register(registerRequestEntity);
  }
}
