import 'package:e_commerce_app/core/utils/user_hive_boxes.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

class FavoriteApi {
  Future<List<ProductModel>> getFavoriteProducts() async {
    final favoritesBox = await UserHiveBoxes.favoritesBox();
    return favoritesBox.values.toList();
  }

  Future<void> removeProductFromFavorites(int productId) async {
    final favoritesBox = await UserHiveBoxes.favoritesBox();
    return await favoritesBox.delete(productId);
  }

  Future<void> addProductToCart(CartItemModel cartProduct) async {
    final cartBox = await UserHiveBoxes.cartBox();
    return await cartBox.put(cartProduct.id, cartProduct);
  }

  Future<CartItemModel?> getProductFromCart(int productId) async {
    final box = await UserHiveBoxes.cartBox();
    return box.get(productId);
  }
}
