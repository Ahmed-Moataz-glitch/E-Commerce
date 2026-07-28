part of 'account_cubit.dart';

sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class GetProfileLoading extends AccountState {}

final class GetProfileSuccess extends AccountState {
  final ProfileResponseEntity profileResponseEntity;
  GetProfileSuccess(this.profileResponseEntity);
}

final class GetProfileError extends AccountState {
  final String message;
  GetProfileError(this.message);
}

final class UpdateUserProfileImageLoading extends AccountState {}

final class UpdateUserProfileImageSuccess extends AccountState {
  final UpdateUserProfileImageResponseEntity updateUserProfileImageResponseEntity;
  UpdateUserProfileImageSuccess(this.updateUserProfileImageResponseEntity);
}

final class UpdateUserProfileImageError extends AccountState {
  final String message;
  UpdateUserProfileImageError(this.message);
}

final class PickImageSuccess extends AccountState {
  final XFile imageFile;
  PickImageSuccess(this.imageFile);
}

final class PickImageError extends AccountState {
  final String message;
  PickImageError(this.message);
}
