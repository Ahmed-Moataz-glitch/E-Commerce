// ignore_for_file: unused_local_variable

import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/core/utils/secure_storage.dart';
import 'package:e_commerce_app/core/utils/user_hive_boxes.dart';
import 'package:e_commerce_app/core/views/pages/hello_page.dart';
import 'package:e_commerce_app/core/views/pages/onboarding_page.dart';
import 'package:e_commerce_app/core/views/widgets/app_section.dart';
import 'package:e_commerce_app/features/auth/data/api/auth_api.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/forget_password_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/register_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/reset_password_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/successful_reset_password_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/verify_code_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/verify_email_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/presentation/view/pages/product_details_page.dart';
import 'package:e_commerce_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<ProductModel>(ProductModelAdapter());
  Hive.registerAdapter<CartItemModel>(CartItemModelAdapter());
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.publishableKey,
  );
  await setupGetIt();
  final token = await SecureStorage.getToken();
  if (token != null) {
    await getIt<AuthApi>().saveLoggedInUserId(token);
  }
  await UserHiveBoxes.openCurrentUserBoxes();
  debugPrint('Token: $token');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.background,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ),
  );
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 869),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: AppConstants.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateInitialRoutes: (initialRoute) {
          if (token != null) {
            return [
              MaterialPageRoute(builder: (context) => const AppSection()),
            ];
          } else {
            return [
              MaterialPageRoute(builder: (context) => const OnboardingPage()),
            ];
          }
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.onboarding:
              return MaterialPageRoute(
                builder: (context) => const OnboardingPage(),
              );
            case AppRoutes.hello:
              return MaterialPageRoute(builder: (context) => const HelloPage());
            case AppRoutes.register:
              return MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              );
            case AppRoutes.login:
              return MaterialPageRoute(builder: (context) => const LoginPage());
            case AppRoutes.forgetPassword:
              final authCubit = settings.arguments as AuthCubit;
              return MaterialPageRoute(
                builder: (context) => ForgetPasswordPage(authCubit: authCubit),
              );
            case AppRoutes.verifyCode:
              final args = settings.arguments as Map<String, dynamic>;
              final authCubit = args['authCubit'] as AuthCubit;
              final email = args['email'] as String;
              return MaterialPageRoute(
                builder: (context) =>
                    VerifyCodePage(authCubit: authCubit, email: email),
              );
            case AppRoutes.verifyEmail:
              final args = settings.arguments as Map<String, dynamic>;
              final authCubit = args['authCubit'] as AuthCubit;
              final email = args['email'] as String;
              return MaterialPageRoute(
                builder: (context) =>
                    VerifyEmailPage(email: email, authCubit: authCubit),
              );
            case AppRoutes.resetPassword:
              final args = settings.arguments as Map<String, dynamic>;
              final authCubit = args['authCubit'] as AuthCubit;
              final email = args['email'] as String;
              final otp = args['otp'] as String;
              return MaterialPageRoute(
                builder: (context) => ResetPasswordPage(
                  authCubit: authCubit,
                  email: email,
                  otp: otp,
                ),
              );
            case AppRoutes.successfulResetPassword:
              return MaterialPageRoute(
                builder: (context) => const SuccessfulResetPasswordPage(),
              );
            case AppRoutes.appSection:
              return MaterialPageRoute(
                builder: (context) => const AppSection(),
              );
            case AppRoutes.productDetails:
              final args = settings.arguments as Map<String, dynamic>;
              final product = args['product'] as ProductsResponseEntity;
              final homeCubit = args['homeCubit'] as HomeCubit;
              return MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(product: product, homeCubit: homeCubit),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
