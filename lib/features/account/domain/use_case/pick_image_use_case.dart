import 'package:e_commerce_app/features/account/domain/repo/repo/account_repo.dart';
import 'package:image_picker/image_picker.dart';

class PickImageUseCase {
  final AccountRepo _accountRepo;
  PickImageUseCase(this._accountRepo);

  Future<XFile?> call() {
    return _accountRepo.pickImage();
  }
}