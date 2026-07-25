import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';

class ValidateOtpUseCase {
  final AuthRepo _authRepo;
  ValidateOtpUseCase(this._authRepo);

  Future<bool> call({required String email, required String otp}) {
    return _authRepo.validateOtp(email: email, otp: otp);
  }
}