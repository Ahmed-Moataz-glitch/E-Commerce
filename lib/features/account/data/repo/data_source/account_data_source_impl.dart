import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/data/api/account_api.dart';
import 'package:e_commerce_app/features/account/data/model/profile_response_dto.dart';
import 'package:e_commerce_app/features/account/data/model/update_user_profile_image_request_dto.dart';
import 'package:e_commerce_app/features/account/data/model/update_user_profile_image_response_dto.dart';
import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/repo/data_source/account_data_source.dart';
import 'package:image_picker/image_picker.dart';

class AccountDataSourceImpl extends AccountDataSource {
  final AccountApi _accountApi;
  AccountDataSourceImpl(this._accountApi);

  @override
  Future<ApiResult<ProfileResponseEntity>> getProfile() async {
    final result = await _accountApi.getProfile();
    switch (result) {
      case ApiSuccess<ProfileResponseDto>():
        return ApiSuccess<ProfileResponseEntity>(result.data?.toEntity());
      case ApiError<ProfileResponseDto>():
        return ApiError<ProfileResponseEntity>(result.message);
    }
  }

  @override
  Future<ApiResult<UpdateUserProfileImageResponseEntity>> updateProfile(UpdateUserProfileImageRequestEntity updateUserProfileImageRequestEntity) async {
    final result = await _accountApi.updateProfile(
      UpdateUserProfileImageRequestDto(
        image: updateUserProfileImageRequestEntity.image,
      ),
    );
    switch (result) {
      case ApiSuccess<UpdateUserProfileImageResponseDto>():
        return ApiSuccess<UpdateUserProfileImageResponseEntity>(result.data?.toEntity());
      case ApiError<UpdateUserProfileImageResponseDto>():
        return ApiError<UpdateUserProfileImageResponseEntity>(result.message);
    }
  }

  @override
  Future<XFile?> pickImage() async {
    return await _accountApi.pickImage();
  }
}