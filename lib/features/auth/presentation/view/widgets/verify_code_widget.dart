import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeWidget extends StatefulWidget {
  final PinInputController pinController;
  const VerifyCodeWidget({super.key, required this.pinController});

  @override
  State<VerifyCodeWidget> createState() => _VerifyCodeWidgetState();
}

class _VerifyCodeWidgetState extends State<VerifyCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      pinController: widget.pinController,
      length: 6,
      theme: MaterialPinTheme(
        fillColor: AppColors.background,
        focusedFillColor: AppColors.background,
        focusedBorderColor: AppColors.primary,
        filledFillColor: AppColors.background,
        filledBorderColor: AppColors.primary,
        followingFillColor: AppColors.background,
        followingBorderColor: AppColors.gray.withAlpha(100),
        completeFillColor: AppColors.background,
        completeBorderColor: AppColors.primary,
        cursorColor: AppColors.primary,
        borderColor: AppColors.gray.withAlpha(100),
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          shadows: [
            Shadow(
              color: AppColors.primary,
              blurRadius: 2.r,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        errorBorderColor: AppColors.red,
        errorTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.red,
        ),
      ),
      onCompleted: (String value) {
        debugPrint('Completed: $value');
      },
    );
  }
}