import 'package:e_commerce_app/features/cart/domain/repo/repo/cart_repo.dart';

class RemoveProductFromCartUseCase {
  final CartRepo cartRepo;
  RemoveProductFromCartUseCase(this.cartRepo);

  Future<void> call(int productId) {
    return cartRepo.removeProductFromCart(productId);
  }
}