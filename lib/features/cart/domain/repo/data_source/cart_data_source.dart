import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

abstract class CartDataSource {
  List<CartItemModel> getCartProducts();

  Future<void> removeProductFromCart(int productId);
}
