import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetProductFromCartUseCase {
  final HomeRepo _homeRepo;
  GetProductFromCartUseCase(this._homeRepo);

  ProductModel? call(int productId) {
    return _homeRepo.getProductFromCart(productId);
  }
}