import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class AddProductToCartUseCase {
  final HomeRepo _homeRepo;
  AddProductToCartUseCase(this._homeRepo);

  Future<void> call(CartItemModel product) {
    return _homeRepo.addProductToCart(product);
  }
}