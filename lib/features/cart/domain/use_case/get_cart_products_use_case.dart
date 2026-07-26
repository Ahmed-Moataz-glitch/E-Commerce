import 'package:e_commerce_app/features/cart/domain/repo/repo/cart_repo.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class GetCartProductsUseCase {
  final CartRepo _cartRepo;
  GetCartProductsUseCase(this._cartRepo);

  List<CartItemModel> call() {
    return _cartRepo.getCartProducts();
  }
}