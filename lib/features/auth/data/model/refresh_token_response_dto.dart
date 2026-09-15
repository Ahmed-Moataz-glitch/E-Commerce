import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_response_entity.dart';

class RefreshTokenResponseDto {
  String? accessToken;
  String? refreshToken;

  RefreshTokenResponseDto({this.accessToken, this.refreshToken});

  RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  RefreshTokenResponseEntity toEntity() {
    return RefreshTokenResponseEntity(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
  }
}
