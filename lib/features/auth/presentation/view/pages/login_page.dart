import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_toast.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/text_form_field_widget.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:e_commerce_app/features/auth/domain/entities/login_request_entity.dart';
import 'package:e_commerce_app/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit authCubit;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    authCubit = getIt<AuthCubit>();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    authCubit.close();
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listenWhen: (previous, current) => 
            current is LoginLoading ||
            current is LoginSuccess ||
            current is LoginError,
        listener: (context, state) {
          if(state is LoginLoading) {
            AppDialogs.showLoadingDialog(context, title: 'Logging in...');
          }
          if(state is LoginSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.appSection,
              (route) => false,
            );
          }
          if(state is LoginError) {
            Navigator.of(context).pop();
            AppToast.showToast(context: context, title: 'Error', description: state.message, type: ToastificationType.error);
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
                  hintText: 'Enter your password',
                  isPassword: true,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.forgetPassword,
                        arguments: authCubit,
                      );
                    },
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        color: AppColors.black.withAlpha(200),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.08),
                MainButton(
                  onPressed: () async {
                    await authCubit.login(
                      LoginRequestEntity(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                  },
                  text: 'Login',
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.register);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                        children: [
                          TextSpan(
                            text: 'sign up',
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
