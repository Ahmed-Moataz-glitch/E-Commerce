import 'package:e_commerce_app/features/cart/domain/repo/data_source/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/repo/repo/cart_repo.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class CartRepoImpl extends CartRepo {
  final CartDataSource _cartDataSource;
  CartRepoImpl(this._cartDataSource);

  @override
  Future<List<CartItemModel>> getCartProducts() async {
    return await _cartDataSource.getCartProducts();
  }
  
  @override
  Future<void> removeProductFromCart(int productId) async {
    return await _cartDataSource.removeProductFromCart(productId);
  }
  
  @override
  Future<int> clearCart() async {
    return await _cartDataSource.clearCart();
  }
}
