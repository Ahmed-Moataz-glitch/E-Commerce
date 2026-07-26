part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartProducts extends CartState {
  final List<CartItemModel> cartProducts;
  GetCartProducts(this.cartProducts);
}
