import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class DeleteProductUseCase {
  final HomeRepo _homeRepo;
  DeleteProductUseCase(this._homeRepo);

  Future<void> call(int productId) {
    return _homeRepo.deleteProduct(productId);
  }
}