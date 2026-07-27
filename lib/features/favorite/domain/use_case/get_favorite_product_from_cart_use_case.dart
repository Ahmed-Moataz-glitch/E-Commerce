import 'package:e_commerce_app/features/favorite/domain/repo/repo/favorite_repo.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class GetFavoriteProductFromCartUseCase {
  final FavoriteRepo _favoriteRepo;

  GetFavoriteProductFromCartUseCase(this._favoriteRepo);

  CartItemModel? call(int productId) {
    return _favoriteRepo.getProductFromCart(productId);
  }
}
