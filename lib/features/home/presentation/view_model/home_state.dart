part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetCategoriesLoading extends HomeState {}

final class GetCategoriesSuccess extends HomeState {
  final List<CategoriesResponseEntity> categories;
  GetCategoriesSuccess(this.categories);
}

final class GetCategoriesError extends HomeState {
  final String message;
  GetCategoriesError(this.message);
}

final class GetProductsLoading extends HomeState {}

final class GetProductsSuccess extends HomeState {
  final List<ProductsResponseEntity> products;
  GetProductsSuccess(this.products);
}

final class GetProductsError extends HomeState {
  final String message;
  GetProductsError(this.message);
}

final class AddingProductToCart extends HomeState {}

final class ProductAddedToCart extends HomeState {}

final class ProductAddToCartError extends HomeState {
  final String message;
  ProductAddToCartError(this.message);
}
