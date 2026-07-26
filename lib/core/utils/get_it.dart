import 'package:e_commerce_app/features/auth/data/api/auth_api.dart';
import 'package:e_commerce_app/features/auth/data/repo/data_source/auth_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/data/repo/repo/auth_repo_impl.dart';
import 'package:e_commerce_app/features/auth/domain/repo/data_source/auth_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/repo/repo/auth_repo.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/reset_password_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_existing_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/send_otp_for_new_user_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_case/validate_otp_use_case.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_commerce_app/features/cart/data/api/cart_api.dart';
import 'package:e_commerce_app/features/cart/data/repo/data_source/cart_data_source_impl.dart';
import 'package:e_commerce_app/features/cart/data/repo/repo/cart_repo_impl.dart';
import 'package:e_commerce_app/features/cart/domain/repo/data_source/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/repo/repo/cart_repo.dart';
import 'package:e_commerce_app/features/cart/domain/use_case/get_cart_products_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/use_case/remove_product_from_cart_use_case.dart';
import 'package:e_commerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:e_commerce_app/features/home/data/api/home_api.dart';
import 'package:e_commerce_app/features/home/data/repo/data_source/home_data_source_impl.dart';
import 'package:e_commerce_app/features/home/data/repo/repo/home_repo_impl.dart';
import 'package:e_commerce_app/features/home/domain/repo/data_source/home_data_source.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';
import 'package:e_commerce_app/features/home/domain/use_case/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/delete_product_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_product_from_cart_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_products_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/get_saved_product_use_case.dart';
import 'package:e_commerce_app/features/home/domain/use_case/save_product_use_case.dart';
import 'package:e_commerce_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerSingleton<AuthDataSource>(AuthDataSourceImpl(getIt<AuthApi>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt<AuthDataSource>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<SendOtpForExistingUserUseCase>(
    SendOtpForExistingUserUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<SendOtpForNewUserUseCase>(
    SendOtpForNewUserUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ValidateOtpUseCase>(
    ValidateOtpUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      registerUseCase: getIt<RegisterUseCase>(),
      loginUseCase: getIt<LoginUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      sendOtpForNewUserUseCase: getIt<SendOtpForNewUserUseCase>(),
      sendOtpForExistingUserUseCase: getIt<SendOtpForExistingUserUseCase>(),
      validateOtpUseCase: getIt<ValidateOtpUseCase>(),
    ),
  );

  getIt.registerSingleton<HomeApi>(HomeApi());
  getIt.registerSingleton<HomeDataSource>(HomeDataSourceImpl(getIt<HomeApi>()));
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt<HomeDataSource>()));
  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<GetCategoriesUseCase>(
    GetCategoriesUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<SaveProductUseCase>(
    SaveProductUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<GetSavedProductUseCase>(
    GetSavedProductUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<DeleteProductUseCase>(
    DeleteProductUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<AddProductToCartUseCase>(
    AddProductToCartUseCase(getIt<HomeRepo>()),
  );
  getIt.registerSingleton<GetProductFromCartUseCase>(
    GetProductFromCartUseCase(getIt<HomeRepo>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getProductsUseCase: getIt<GetProductsUseCase>(),
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      saveProductUseCase: getIt<SaveProductUseCase>(),
      getSavedProductUseCase: getIt<GetSavedProductUseCase>(),
      deleteProductUseCase: getIt<DeleteProductUseCase>(),
      addProductToCartUseCase: getIt<AddProductToCartUseCase>(),
      getProductFromCartUseCase: getIt<GetProductFromCartUseCase>(),
    ),
  );

  getIt.registerSingleton<CartApi>(CartApi());
  getIt.registerSingleton<CartDataSource>(CartDataSourceImpl(getIt<CartApi>()));
  getIt.registerSingleton<CartRepo>(CartRepoImpl(getIt<CartDataSource>()));
  getIt.registerSingleton<GetCartProductsUseCase>(
    GetCartProductsUseCase(getIt<CartRepo>()),
  );
  getIt.registerSingleton<RemoveProductFromCartUseCase>(
    RemoveProductFromCartUseCase(getIt<CartRepo>()),
  );
  getIt.registerFactory(
    () => CartCubit(
      getCartProductsUseCase: getIt<GetCartProductsUseCase>(),
      removeProductFromCartUseCase: getIt<RemoveProductFromCartUseCase>(),
    )
  );
}
