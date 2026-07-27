import 'package:e_commerce_app/features/favorite/domain/repo/data_source/favorite_data_source.dart';
import 'package:e_commerce_app/features/favorite/domain/repo/repo/favorite_repo.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  final FavoriteDataSource _favoriteDataSource;
  FavoriteRepoImpl(this._favoriteDataSource);

  @override
  Future<void> addProductToCart(CartItemModel cartProduct) async {
    return await _favoriteDataSource.addProductToCart(cartProduct);
  }

  @override
  List<ProductModel> getFavoriteProducts() {
    return _favoriteDataSource.getFavoriteProducts();
  }

  @override
  Future<void> removeProductFromFavorites(int productId) async {
    return await _favoriteDataSource.removeProductFromFavorites(productId);
  }
  
  @override
  CartItemModel? getProductFromCart(int productId) {
    return _favoriteDataSource.getProductFromCart(productId);
  }
}