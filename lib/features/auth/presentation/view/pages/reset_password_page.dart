import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_toast.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/text_form_field_widget.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthCubit authCubit;
  final String email;
  final String otp;
  const ResetPasswordPage({super.key, required this.email, required this.otp, required this.authCubit});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listenWhen: (previous, current) =>
            current is ResetPasswordLoading ||  
            current is ResetPasswordSuccess || 
            current is ResetPasswordError,
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            AppDialogs.showLoadingDialog(context, title: 'Reset Password...');
          }
          if (state is ResetPasswordSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.successfulResetPassword);
          }
          if (state is ResetPasswordError) {
            AppToast.showToast(
              context: context,
              title: 'Error',
              description: state.message,
              type: ToastificationType.error,
            );
          }
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            top: 36.h,
            right: 16.w,
            left: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
          ),
          child: Column(
            children: [
              Text(
                'Please provide the email address that you used when signed up for your account',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.05),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                      // style: TextStyle(
                      //   fontSize: 18.sp,
                      //   fontWeight: FontWeight.w500,
                      //   color: AppColors.black,
                      // ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormFieldWidget(
                      isPassword: true,
                      obscureText: true,
                      controller: newPasswordController,
                      validator: Validator.validatePassword,
                      hintText: 'Create a new password',
                    ),
                    SizedBox(height: size.height * 0.04),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                      // style: TextStyle(
                      //   fontSize: 18.sp,
                      //   fontWeight: FontWeight.w500,
                      //   color: AppColors.black,
                      // ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormFieldWidget(
                      isPassword: true,
                      obscureText: true,
                      controller: confirmPasswordController,
                      validator: (value) => Validator.validateConfirmPassword(
                        value,
                        newPasswordController.text.trim(),
                      ),
                      hintText: 'Confirm your new password',
                    ),
                    SizedBox(height: size.height * 0.05),
                    MainButton(
                      text: 'Reset Password',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // await widget.authCubit.resetPassword(
                          //   ResetPasswordRequestEntity(
                          //     password: newPasswordController.text.trim(),
                          //   ),
                          // );
                          Navigator.of(context).pushNamed(
                            AppRoutes.successfulResetPassword,
                          );
                          // if (!context.mounted) {
                          //   return;
                          // }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
