import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/pages/hello_page.dart';
import 'package:e_commerce_app/core/views/pages/onboarding_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/login_page.dart';
import 'package:e_commerce_app/features/auth/presentation/view/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.publishableKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 869),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateInitialRoutes: (initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) => const OnboardingPage(),
            ),
          ];
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.hello:
              return MaterialPageRoute(builder: (context) => const HelloPage());
            case AppRoutes.register:
              return MaterialPageRoute(builder: (context) => const RegisterPage());
            case AppRoutes.login:
              return MaterialPageRoute(builder: (context) => const LoginPage());
            default:
              return null;
          }
        },
      ),
    );
  }
}
