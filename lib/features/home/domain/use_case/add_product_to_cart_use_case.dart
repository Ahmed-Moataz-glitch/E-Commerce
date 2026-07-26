import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class AddProductToCartUseCase {
  final HomeRepo _homeRepo;
  AddProductToCartUseCase(this._homeRepo);

  Future<void> call(ProductModel product) {
    return _homeRepo.addProductToCart(product);
  }
}