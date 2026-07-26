import 'package:e_commerce_app/features/cart/data/api/cart_api.dart';
import 'package:e_commerce_app/features/cart/domain/repo/data_source/cart_data_source.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';

class CartDataSourceImpl extends CartDataSource {
  final CartApi _cartApi;
  CartDataSourceImpl(this._cartApi);

  @override
  List<CartItemModel> getCartProducts() {
    return _cartApi.getCartProducts();
  }
  
  @override
  Future<void> removeProductFromCart(int productId) async {
    return await _cartApi.removeProductFromCart(productId);
  }
}