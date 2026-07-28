import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';

class ProfileResponseDto {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  ProfileResponseDto(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.role,
      this.avatar,
      this.creationAt,
      this.updatedAt});

  ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ProfileResponseEntity toEntity() {
    return ProfileResponseEntity(
      id: id ?? 0,
      email: email ?? '',
      password: password ?? '',
      name: name ?? '',
      role: role ?? '',
      avatar: avatar ?? '',
      creationAt: creationAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
