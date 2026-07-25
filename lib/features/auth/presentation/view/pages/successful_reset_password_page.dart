import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfulResetPasswordPage extends StatelessWidget {
  const SuccessfulResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: isLightMode ? AppColors.gray : AppColors.primary.withAlpha(230),
                    borderRadius: BorderRadius.circular(96.r),
                  ),
                ),
                Image.asset(
                  AppAssets.successfulResetPasswordImage,
                  width: size.width * 0.23,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Password reset successfully',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   fontSize: 22.sp,
              //   fontWeight: FontWeight.w700,
              //   color: AppColors.black,
              // ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'You have successfully changed your \npassword. please use your new \npassword to login',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black.withAlpha(200),
              ),
              textAlign: TextAlign.center,
              // style: TextStyle(fontSize: 16.sp, color: AppColors.secondary),
            ),
            SizedBox(height: size.height * 0.04),
            MainButton(
              text: 'Go to login',
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login, 
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
