import 'package:e_commerce_app/features/favorite/domain/use_case/add_favorite_product_to_cart_use_case.dart';
import 'package:e_commerce_app/features/favorite/domain/use_case/get_favorite_products_use_case.dart';
import 'package:e_commerce_app/features/favorite/domain/use_case/get_favorite_product_from_cart_use_case.dart';
import 'package:e_commerce_app/features/favorite/domain/use_case/remove_products_from_favorites_use_case.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoriteProductsUseCase getFavoriteProductsUseCase;
  final AddFavoriteProductToCartUseCase addProductToCartUseCase;
  final RemoveProductsFromFavoritesUseCase removeProductsFromFavoritesUseCase;
  final GetFavoriteProductFromCartUseCase getProductFromCartUseCase;
  FavoriteCubit({
    required this.getFavoriteProductsUseCase,
    required this.addProductToCartUseCase,
    required this.removeProductsFromFavoritesUseCase,
    required this.getProductFromCartUseCase,
  }) : super(FavoriteInitial());

  void getFavoriteProducts() {
    final favoriteProducts = getFavoriteProductsUseCase.call();
    emit(GetFavoriteProducts(favoriteProducts));
  }

  Future<void> addProductToCart(CartItemModel cartProduct) async {
    try {
      await addProductToCartUseCase.call(cartProduct);
      emit(ProductAddedToCart());
    } catch (e) {
      emit(AddingProductToCartError(e.toString()));
    }
  }

  Future<void> removeProductFromFavorites(int productId) async {
    await removeProductsFromFavoritesUseCase.call(productId);
  }

  CartItemModel? getProductFromCart(int productId) {
    return getProductFromCartUseCase.call(productId);
  }
}
