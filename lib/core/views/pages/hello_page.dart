import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: size.width, height: 100.h),
            SvgPicture.asset(AppAssets.helloImage),
            SizedBox(height: 20.h),
            Text(
              'Hello!',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 48.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            MainButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.register);
              },
              text: 'Signup',
            ),
            SizedBox(height: size.height * 0.02),
            SecondaryButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.register);
              },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
