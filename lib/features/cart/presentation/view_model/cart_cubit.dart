import 'package:e_commerce_app/features/cart/domain/use_case/get_cart_products_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/use_case/remove_product_from_cart_use_case.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartProductsUseCase getCartProductsUseCase;
  final RemoveProductFromCartUseCase removeProductFromCartUseCase;
  CartCubit({
    required this.getCartProductsUseCase,
    required this.removeProductFromCartUseCase,
  }) : super(CartInitial());

  void getCartProducts() {
    final cartProducts = getCartProductsUseCase.call();
    emit(GetCartProducts(cartProducts));
  }

  Future<void> removeProductFromCart(int productId) async {
    return await removeProductFromCartUseCase.call(productId);
  }

  int getSubtotalPrice(
  {
    required List<CartItemModel> cartProducts,
  }) {
    return cartProducts.fold(0, (sum, p) => sum + (p.itemCount * p.price));
  }

  int getTotalPrice(
  {
    required List<CartItemModel> cartProducts,
    required int shippingFee,
  }) {
    return cartProducts.fold(0, (sum, p) => sum + (p.itemCount * p.price)) + shippingFee;
  }
}
