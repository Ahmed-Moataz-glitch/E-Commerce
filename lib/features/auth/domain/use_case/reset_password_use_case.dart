import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepo _authRepo;
  ResetPasswordUseCase(this._authRepo);

  Future<ApiResult<ResetPasswordResponseEntity>> call(ResetPasswordRequestEntity resetPasswordRequestEntity) {
    return _authRepo.resetPassword(resetPasswordRequestEntity);
  }
}