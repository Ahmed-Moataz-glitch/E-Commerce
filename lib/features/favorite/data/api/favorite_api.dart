import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteApi {
  List<ProductModel> getFavoriteProducts() {
    final favoritesBox = Hive.box<ProductModel>(AppConstants.favoritesBox);
    return favoritesBox.values.toList();
  }

  Future<void> removeProductFromFavorites(int productId) async {
    final favoritesBox = Hive.box<ProductModel>(AppConstants.favoritesBox);
    return await favoritesBox.delete(productId);
  }

  Future<void> addProductToCart(CartItemModel cartProduct) async {
    final cartBox = Hive.box<CartItemModel>(AppConstants.cartBox);
    return await cartBox.put(cartProduct.id, cartProduct);
  }

  CartItemModel? getProductFromCart(int productId) {
    final box = Hive.box<CartItemModel>(AppConstants.cartBox);
    return box.get(productId);
  }
}