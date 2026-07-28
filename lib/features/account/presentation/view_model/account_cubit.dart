import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/use_case/get_profile_use_case.dart';
import 'package:e_commerce_app/features/account/domain/use_case/pick_image_use_case.dart';
import 'package:e_commerce_app/features/account/domain/use_case/update_user_profile_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateUserProfileImageUseCase updateUserProfileImageUseCase;
  final PickImageUseCase pickImageUseCase;
  AccountCubit({
    required this.getProfileUseCase,
    required this.updateUserProfileImageUseCase,
    required this.pickImageUseCase,
  }) : super(AccountInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await getProfileUseCase.call();
    switch (result) {
      case ApiSuccess<ProfileResponseEntity>():
        emit(GetProfileSuccess(result.data!));
        break;
      case ApiError<ProfileResponseEntity>():
        emit(GetProfileError(result.message));
        break;
    }
  }

  Future<void> updateUserProfileImage(UpdateUserProfileImageRequestEntity updateUserProfileImageRequestEntity) async {
    emit(UpdateUserProfileImageLoading());
    final result = await updateUserProfileImageUseCase.call(updateUserProfileImageRequestEntity);
    switch (result) {
      case ApiSuccess<UpdateUserProfileImageResponseEntity>():
        emit(UpdateUserProfileImageSuccess(result.data!));
        break;
      case ApiError<UpdateUserProfileImageResponseEntity>():
        emit(UpdateUserProfileImageError(result.message));
        break;
    }
  }

  Future<void> pickImage() async {
    final result = await pickImageUseCase.call();
    if (result != null) {
      emit(PickImageSuccess(result));
    } else {
      emit(PickImageError('No image selected'));
    }
  }
}
