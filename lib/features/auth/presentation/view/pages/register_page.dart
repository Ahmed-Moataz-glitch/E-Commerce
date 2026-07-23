import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/text_form_field_widget.dart';
import 'package:e_commerce_app/core/views/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
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
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
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
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
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
              MainButton(onPressed: () {}, text: 'Sign up'),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.login,
                    );
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
    );
  }
}
