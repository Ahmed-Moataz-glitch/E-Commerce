// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';

class UpdateUserProfileImageRequestDto {
  final File? image;
  
  UpdateUserProfileImageRequestDto({
    this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = image;
    return data;
  }

  UpdateUserProfileImageRequestEntity toEntity() {
    return UpdateUserProfileImageRequestEntity(image: image ?? File(''));
  }
}
