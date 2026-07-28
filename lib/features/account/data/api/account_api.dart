import 'dart:convert';

import 'package:e_commerce_app/core/utils/secure_storage.dart';
import 'package:e_commerce_app/features/account/data/model/update_user_profile_image_request_dto.dart';
import 'package:e_commerce_app/features/account/data/model/update_user_profile_image_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/utils/app_api.dart';
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/data/model/profile_response_dto.dart';
import 'package:image_picker/image_picker.dart';

class AccountApi {
  final ImagePicker _imagePicker = ImagePicker();

  Future<ApiResult<ProfileResponseDto>> getProfile() async {
    final token = await SecureStorage.getToken();
    final url = Uri.https(AppApi.baseUrl, AppApi.profileEndpoint);
    try {
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        return ApiError<ProfileResponseDto>(
          'Failed to fetch profile. Status code: ${response.statusCode}',
        );
      }
      final responseBody = response.body;
      final json = jsonDecode(responseBody);
      return ApiSuccess<ProfileResponseDto>(ProfileResponseDto.fromJson(json));
    } catch (e) {
      return ApiError<ProfileResponseDto>(e.toString());
    }
  }

  Future<ApiResult<UpdateUserProfileImageResponseDto>> updateProfile(
    UpdateUserProfileImageRequestDto updateUserProfileImageRequestDto,
  ) async {
    final url = Uri.https(AppApi.baseUrl, AppApi.uploadProfileImageEndpoint);
    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          updateUserProfileImageRequestDto.image!.path,
        ),
      );
      var response = await request.send();
      if (response.statusCode != 201) {
        return ApiError<UpdateUserProfileImageResponseDto>(
          'Failed to update profile. Status code: ${response.statusCode}',
        );
      }
      final responseBody = await response.stream.bytesToString();
      final json = jsonDecode(responseBody);
      return ApiSuccess<UpdateUserProfileImageResponseDto>(UpdateUserProfileImageResponseDto.fromJson(json));
    } catch (e) {
      return ApiError<UpdateUserProfileImageResponseDto>(e.toString());
    }
  }

  Future<XFile?> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      return null;
    }
  }
}
