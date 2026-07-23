import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';

class RegisterRequestDto {
  String? name;
  String? email;
  String? password;
  String? avatar;

  RegisterRequestDto({this.name, this.email, this.password, this.avatar});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = avatar;
    return data;
  }

  RegisterRequestEntity toEntity() {
    return RegisterRequestEntity(
      name: name ?? '',
      email: email ?? '',
      password: password ?? '',
      avatar: avatar ?? '',
    );
  }
}
