import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/repo/data_source/account_data_source.dart';
import 'package:e_commerce_app/features/account/domain/repo/repo/account_repo.dart';
import 'package:image_picker/image_picker.dart';

class AccountRepoImpl extends AccountRepo {
  final AccountDataSource _accountDataSource;
  AccountRepoImpl(this._accountDataSource);

  @override
  Future<ApiResult<ProfileResponseEntity>> getProfile() async {
    return await _accountDataSource.getProfile();
  }

  @override
  Future<ApiResult<UpdateUserProfileImageResponseEntity>> updateProfile(UpdateUserProfileImageRequestEntity updateUserProfileImageRequestEntity) async {
    return await _accountDataSource.updateProfile(updateUserProfileImageRequestEntity);
  }

  @override
  Future<XFile?> pickImage() async {
    return await _accountDataSource.pickImage();
  }
}
