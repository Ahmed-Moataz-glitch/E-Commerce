import 'package:e_commerce_app/features/cart/domain/repo/repo/cart_repo.dart';

class ClearCartUseCase {
  final CartRepo _cartRepo;
  ClearCartUseCase(this._cartRepo);

  Future<int> call() {
    return _cartRepo.clearCart();
  }
}