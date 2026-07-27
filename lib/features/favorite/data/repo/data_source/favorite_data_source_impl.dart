import 'package:e_commerce_app/features/favorite/data/api/favorite_api.dart';
import 'package:e_commerce_app/features/favorite/domain/repo/data_source/favorite_data_source.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

class FavoriteDataSourceImpl extends FavoriteDataSource {
  final FavoriteApi _favoriteApi;
  FavoriteDataSourceImpl(this._favoriteApi);

  @override
  Future<void> addProductToCart(CartItemModel cartProduct) async {
    return await _favoriteApi.addProductToCart(cartProduct);
  }

  @override
  List<ProductModel> getFavoriteProducts() {
    return _favoriteApi.getFavoriteProducts();
  }

  @override
  Future<void> removeProductFromFavorites(int productId) async {
    return await _favoriteApi.removeProductFromFavorites(productId);
  }
  
  @override
  CartItemModel? getProductFromCart(int productId) {
    return _favoriteApi.getProductFromCart(productId);
  }
}