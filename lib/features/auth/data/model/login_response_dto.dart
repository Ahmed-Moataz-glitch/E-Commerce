import 'package:e_commerce_app/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseDto {
  String? accessToken;
  String? refreshToken;

  LoginResponseDto({this.accessToken, this.refreshToken});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
  }
}
