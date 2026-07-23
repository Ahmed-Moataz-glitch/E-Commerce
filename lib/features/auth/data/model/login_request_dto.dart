import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';

class LoginRequestDto {
  String? email;
  String? password;

  LoginRequestDto({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  LoginRequestEntity toEntity() {
    return LoginRequestEntity(
      email: email ?? '',
      password: password ?? '',
    );
  }
}
