import 'package:e_commerce_app/features/favorite/domain/repo/repo/favorite_repo.dart';

class RemoveProductsFromFavoritesUseCase {
  final FavoriteRepo _favoriteRepo;
  RemoveProductsFromFavoritesUseCase(this._favoriteRepo);

  Future<void> call(int productId) {
    return _favoriteRepo.removeProductFromFavorites(productId);
  }
}