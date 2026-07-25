import 'package:e_commerce_app/features/auth/domain/entities/reset_password_response_entity.dart';

class ResetPasswordResponseDto {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  ResetPasswordResponseDto(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.role,
      this.avatar,
      this.creationAt,
      this.updatedAt});

  ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(
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
