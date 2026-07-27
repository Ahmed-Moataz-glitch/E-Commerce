import 'package:e_commerce_app/features/favorite/domain/repo/repo/favorite_repo.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class AddFavoriteProductToCartUseCase {
  final FavoriteRepo _favoriteRepo;

  AddFavoriteProductToCartUseCase(this._favoriteRepo);

  Future<void> call(CartItemModel cartProduct) async {
    await _favoriteRepo.addProductToCart(cartProduct);
  }
}
