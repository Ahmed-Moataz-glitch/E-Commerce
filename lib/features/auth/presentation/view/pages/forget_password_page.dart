import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/text_form_field_widget.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  final AuthCubit authCubit;
  const ForgetPasswordPage({super.key, required this.authCubit});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forget Password',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listenWhen: (previous, current) =>
            current is SendingOtp ||
            current is OtpSent ||
            current is SendingOtpError,
        listener: (context, state) {
          if (state is SendingOtp) {
            AppDialogs.showLoadingDialog(context, title: 'Sending OTP...');
          }
          if (state is OtpSent) {
            Navigator.of(context).pushNamed(
              AppRoutes.verifyCode,
              arguments: {
                'email': emailController.text.trim(),
                'authCubit': widget.authCubit,
              },
            );
          }
          if (state is SendingOtpError) {
            Navigator.of(context).pop();
            AppDialogs.showSnackBar(
              context: context,
              message: state.message,
              isError: true,
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
                      'Email',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormFieldWidget(
                      controller: emailController,
                      validator: Validator.validateEmail,
                      hintText: 'name@example.com',
                    ),
                    SizedBox(height: size.height * 0.05),
                    MainButton(
                      text: 'Send OTP',
                      onPressed: () async {
                        // if (formKey.currentState!.validate()) {
                        //   await widget.authCubit.sendOtpForExistingUser(
                        //     emailController.text.trim(),
                        //   );
                        // }
                        Navigator.of(context).pushNamed(
                          AppRoutes.verifyCode,
                          arguments: {
                            'email': emailController.text.trim(),
                            'authCubit': widget.authCubit,
                          },
                        );
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
