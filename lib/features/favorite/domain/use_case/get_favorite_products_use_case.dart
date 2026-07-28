import 'package:e_commerce_app/features/favorite/domain/repo/repo/favorite_repo.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

class GetFavoriteProductsUseCase {
  final FavoriteRepo favoriteRepo;
  GetFavoriteProductsUseCase(this.favoriteRepo);

  Future<List<ProductModel>> call() {
    return favoriteRepo.getFavoriteProducts();
  }
}
