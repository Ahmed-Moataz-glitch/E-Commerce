import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/repo/repo/account_repo.dart';

class UpdateUserProfileImageUseCase {
  final AccountRepo _accountRepo;
  UpdateUserProfileImageUseCase(this._accountRepo);

  Future<ApiResult<UpdateUserProfileImageResponseEntity>> call(UpdateUserProfileImageRequestEntity updateUserProfileImageRequestEntity) {
    return _accountRepo.updateProfile(updateUserProfileImageRequestEntity);
  }
}