import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_request_dto.dart';
import 'package:e_commerce_app/features/auth/data/model/refresh_token_response_dto.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';

void main() {
  group('Auth Refresh Token & Register Models', () {
    test('RefreshTokenResponseDto fromJson and toEntity converts properly', () {
      final json = {
        'access_token': 'mock_access_token',
        'refresh_token': 'mock_refresh_token',
      };
      final dto = RefreshTokenResponseDto.fromJson(json);
      expect(dto.accessToken, 'mock_access_token');
      expect(dto.refreshToken, 'mock_refresh_token');

      final entity = dto.toEntity();
      expect(entity.accessToken, 'mock_access_token');
      expect(entity.refreshToken, 'mock_refresh_token');
    });

    test('RefreshTokenRequestDto toJson produces valid payload', () {
      final dto = RefreshTokenRequestDto(refreshToken: 'test_token');
      final json = dto.toJson();
      expect(json['refreshToken'], 'test_token');
    });

    test('RegisterRequestEntity sets default avatar', () {
      final entity = RegisterRequestEntity(
        name: 'john',
        email: 'john@mail.com',
        password: 'password123',
      );
      expect(entity.avatar, 'https://picsum.photos/800');
    });

    test('Validator.validateUsername validates properly', () {
      expect(Validator.validateUsername(''), 'Username cannot be empty');
      expect(Validator.validateUsername('   '), 'Username cannot be empty');
      expect(Validator.validateUsername(null), 'Username cannot be empty');
      expect(Validator.validateUsername('ahmed'), null);
    });

    test('Validator.validatePassword validates Platzi alphanumeric rules', () {
      expect(Validator.validatePassword(''), 'Password cannot be empty');
      expect(Validator.validatePassword(null), 'Password cannot be empty');
      expect(Validator.validatePassword('123'), 'Password must be at least 4 characters');
      expect(Validator.validatePassword('ahmed123@Aa'), 'Password must contain only letters and numbers');
      expect(Validator.validatePassword('pass!word'), 'Password must contain only letters and numbers');
      expect(Validator.validatePassword('ahmed123Aa'), null);
      expect(Validator.validatePassword('123456'), null);
      expect(Validator.validatePassword('Pass123'), null);
    });
  });
}
