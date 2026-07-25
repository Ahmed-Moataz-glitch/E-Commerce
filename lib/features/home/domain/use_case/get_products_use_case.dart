import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetProductsUseCase {
  final HomeRepo _homeRepo;
  GetProductsUseCase(this._homeRepo);

  Future<ApiResult<List<ProductsResponseEntity>>> call() {
    return _homeRepo.getProducts();
  }
}
