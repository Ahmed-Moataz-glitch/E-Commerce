import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetProductFromCartUseCase {
  final HomeRepo _homeRepo;
  GetProductFromCartUseCase(this._homeRepo);

  CartItemModel? call(int productId) {
    return _homeRepo.getProductFromCart(productId);
  }
}
