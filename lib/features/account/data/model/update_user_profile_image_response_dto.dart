import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_response_entity.dart';

class UpdateUserProfileImageResponseDto {
  String? originalname;
  String? filename;
  String? location;

  UpdateUserProfileImageResponseDto(
      {this.originalname, this.filename, this.location});

  UpdateUserProfileImageResponseDto.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

  UpdateUserProfileImageResponseEntity toEntity() {
    return UpdateUserProfileImageResponseEntity(
      originalname: originalname ?? '',
      filename: filename ?? '',
      location: location ?? '',
    );
  }
}
