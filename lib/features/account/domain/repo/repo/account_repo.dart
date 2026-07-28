import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class AccountRepo {
  Future<ApiResult<ProfileResponseEntity>> getProfile();

  Future<ApiResult<UpdateUserProfileImageResponseEntity>> updateProfile(
    UpdateUserProfileImageRequestEntity updateUserProfileImageRequestEntity,
  );

  Future<XFile?> pickImage();
}