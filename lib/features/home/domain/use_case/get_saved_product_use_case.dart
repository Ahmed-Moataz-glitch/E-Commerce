import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetSavedProductUseCase {
  final HomeRepo _homeRepo;
  GetSavedProductUseCase(this._homeRepo);

  Future<ProductModel?> call(int productId) {
    return _homeRepo.getSavedProduct(productId);
  }
}
