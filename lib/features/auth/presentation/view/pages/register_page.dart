import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/text_form_field_widget.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:e_commerce_app/features/auth/domain/entities/register_request_entity.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthCubit authCubit;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    authCubit = getIt<AuthCubit>();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    authCubit.close();
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listenWhen: (previous, current) =>
            current is RegisterLoading ||
            current is RegisterSuccess ||
            current is RegisterError,
        listener: (context, state) {
          if (state is RegisterLoading) {
            AppDialogs.showLoadingDialog(context, title: 'Registering...');
          }
          if (state is RegisterSuccess) {
            Navigator.of(context).pop();
            AppDialogs.showLoadingDialog(context, title: 'Sending OTP...');
            Navigator.of(context).pushNamed(
              AppRoutes.verifyEmail,
              arguments: {
                'email': emailController.text.trim(),
                'authCubit': authCubit,
              },
            );
          }
          if (state is RegisterError) {
            Navigator.of(context).pop();
            AppDialogs.showSnackBar(
              context: context,
              message: state.message,
              isError: true,
            );
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormFieldWidget(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: 'youusefmhmd30@gmail.com',
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormFieldWidget(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: 'Create a password',
                  isPassword: true,
                  obscureText: true,
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  'Confirm password',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormFieldWidget(
                  controller: confirmPasswordController,
                  validator: Validator.validatePassword,
                  hintText: 'Confirm your password',
                  isPassword: true,
                  obscureText: true,
                ),
                SizedBox(height: size.height * 0.08),
                MainButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await authCubit.register(
                        RegisterRequestEntity(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                      // await authCubit.sendOtpForNewUser(emailController.text.trim());
                    }
                  },
                  text: 'Sign up',
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.login);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
