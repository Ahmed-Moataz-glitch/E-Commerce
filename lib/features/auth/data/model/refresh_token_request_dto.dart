import 'package:e_commerce_app/features/auth/domain/entities/refresh_token_request_entity.dart';

class RefreshTokenRequestDto {
  String? refreshToken;

  RefreshTokenRequestDto({this.refreshToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    return data;
  }

  RefreshTokenRequestEntity toEntity() {
    return RefreshTokenRequestEntity(refreshToken: refreshToken ?? '');
  }
}
