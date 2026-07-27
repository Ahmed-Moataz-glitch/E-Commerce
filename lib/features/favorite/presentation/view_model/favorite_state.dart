part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class GetFavoriteProducts extends FavoriteState {
  final List<ProductModel> favoriteProducts;

  GetFavoriteProducts(this.favoriteProducts);
}

final class ProductAddedToCart extends FavoriteState {}

final class AddingProductToCartError extends FavoriteState {
  final String errorMessage;

  AddingProductToCartError(this.errorMessage);
}
