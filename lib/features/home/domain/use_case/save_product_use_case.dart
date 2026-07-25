import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class SaveProductUseCase {
  final HomeRepo _homeRepo;
  SaveProductUseCase(this._homeRepo);

  Future<void> call(ProductModel product) {
    return _homeRepo.saveProduct(product);
  } 
}