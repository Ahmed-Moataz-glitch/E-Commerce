import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/account/domain/entities/profile_response_entity.dart';
import 'package:e_commerce_app/features/account/domain/repo/repo/account_repo.dart';

class GetProfileUseCase {
  final AccountRepo accountRepo;
  GetProfileUseCase(this.accountRepo);

  Future<ApiResult<ProfileResponseEntity>> call() {
    return accountRepo.getProfile();
  }
}