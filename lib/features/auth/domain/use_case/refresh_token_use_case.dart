import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_request_entity.dart';
import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_response_entity.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class RefreshTokenUseCase {
  final AuthRepo _authRepo;
  RefreshTokenUseCase(this._authRepo);

  Future<ApiResult<RefreshTokenResponseEntity>> call(
    RefreshTokenRequestEntity refreshTokenRequestEntity,
  ) {
    return _authRepo.refreshToken(refreshTokenRequestEntity);
  }
}
