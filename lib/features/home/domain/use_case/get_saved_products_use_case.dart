import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetSavedProductsUseCase {
  final HomeRepo _homeRepo;
  GetSavedProductsUseCase(this._homeRepo);

  List<ProductModel> call() {
    return _homeRepo.getSavedProducts();
  }
}