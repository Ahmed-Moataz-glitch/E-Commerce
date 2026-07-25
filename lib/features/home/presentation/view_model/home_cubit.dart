import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/categories_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/use_case/delete_product_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_products_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_saved_products_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/save_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final SaveProductUseCase saveProductUseCase;
  final GetSavedProductsUseCase getSavedProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.saveProductUseCase,
    required this.getSavedProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(HomeInitial());

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final result = await getProductsUseCase.call();
    switch (result) {
      case ApiSuccess<List<ProductsResponseEntity>>():
        emit(GetProductsSuccess(result.data!));
      case ApiError<List<ProductsResponseEntity>>():
        emit(GetProductsError(result.message));
    }
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final result = await getCategoriesUseCase.call();
    switch (result) {
      case ApiSuccess<List<CategoriesResponseEntity>>():
        emit(GetCategoriesSuccess(result.data!));
      case ApiError<List<CategoriesResponseEntity>>():
        emit(GetCategoriesError(result.message));
    }
  }

  Future<void> saveProduct(ProductModel product) async {
    await saveProductUseCase.call(product);
  }

  List<ProductModel> getSavedProducts() {
    return getSavedProductsUseCase.call();
  }

  Future<void> deleteProduct(int productId) async {
    await deleteProductUseCase.call(productId);
  }
}
