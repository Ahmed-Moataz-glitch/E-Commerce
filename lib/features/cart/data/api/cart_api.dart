import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartApi {
  List<CartItemModel> getCartProducts() {
    final cartBox = Hive.box<CartItemModel>(AppConstants.cartBox);
    return cartBox.values.toList();
  }

  Future<void> removeProductFromCart(int productId) async {
    final cartBox = Hive.box<CartItemModel>(AppConstants.cartBox);
    return await cartBox.delete(productId);
  }
}