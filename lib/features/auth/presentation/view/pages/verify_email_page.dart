// ignore_for_file: use_build_context_synchronously
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/auth/presentation/view/widgets/timer_widget.dart';
import 'package:e_commerce_app/features/auth/presentation/view/widgets/verify_code_widget.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailPage extends StatefulWidget {
  final AuthCubit authCubit;
  final String? email;
  const VerifyEmailPage({super.key, required this.email, required this.authCubit});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late PinInputController otpController;

  @override
  void initState() {
    super.initState();
    otpController = PinInputController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listenWhen: (previous, current) =>
            current is ReSendingOtp ||
            current is OtpReSent ||
            current is ReSendingOtpError ||
            current is OtpVerified ||
            current is VerifyingOtpError,
        listener: (context, state) {
          if (state is ReSendingOtp) {
            AppDialogs.showLoadingDialog(context, title: 'Resending OTP...');
          }
          if (state is OtpReSent) {
            AppDialogs.showSnackBar(context: context, message: state.message);
          }
          if (state is ReSendingOtpError) {
            Navigator.of(context).pop();
            AppDialogs.showSnackBar(
              context: context,
              message: state.message,
              isError: true,
            );
          }
          if (state is OtpVerified) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
          }
          if (state is VerifyingOtpError) {
            AppDialogs.showSnackBar(
              context: context,
              message: state.message,
              isError: true,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),
          child: Column(
            children: [
              Text(
                'Please provide the email address that you used when signed up for your account',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.05),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  text: 'OTP has been sent to ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: widget.email ?? 'ahmedmoataz123@gmail.com',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              VerifyCodeWidget(pinController: otpController),
              SizedBox(height: size.height * 0.04),
              MainButton(
                text: 'Verify',
                onPressed: () async {
                  await widget.authCubit.validateOtp(
                    email: widget.email ?? '',
                    otp: otpController.text.trim(),
                  );
                },
              ),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: () async {
                  await widget.authCubit.resendOtpForNewUser(widget.email ?? '');
                },
                child: Text.rich(
                  TextSpan(
                    text: 'Didn\'t receive the code? ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: 'Resend Code',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const TimerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
