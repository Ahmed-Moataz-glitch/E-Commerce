import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

abstract class FavoriteRepo {
  Future<List<ProductModel>> getFavoriteProducts();

  Future<void> removeProductFromFavorites(int productId);

  Future<void> addProductToCart(CartItemModel cartProduct);

  Future<CartItemModel?> getProductFromCart(int productId);
}
