import 'package:e_commerce_app/features/auth/domain/entities/reset_password_request_entity.dart';

class ResetPasswordRequestDto {
  String? password;

  ResetPasswordRequestDto({this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    return data;
  }

  ResetPasswordRequestEntity toEntity() {
    return ResetPasswordRequestEntity(password: password ?? '');
  }
}
