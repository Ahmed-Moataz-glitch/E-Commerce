import 'package:e_commerce_app/core/utils/user_hive_boxes.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class CartApi {
  Future<List<CartItemModel>> getCartProducts() async {
    final cartBox = await UserHiveBoxes.cartBox();
    return cartBox.values.toList();
  }

  Future<void> removeProductFromCart(int productId) async {
    final cartBox = await UserHiveBoxes.cartBox();
    return await cartBox.delete(productId);
  }

  Future<int> clearCart() async {
    final cartBox = await UserHiveBoxes.cartBox();
    return await cartBox.clear();
  }
}
