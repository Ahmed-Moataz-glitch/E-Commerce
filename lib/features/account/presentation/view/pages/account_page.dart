import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/utils/app_toast.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/secure_storage.dart';
import 'package:e_commerce_app/core/views/widgets/secondary_button.dart';
import 'package:e_commerce_app/features/account/domain/entities/update_user_profile_image_request_entity.dart';
import 'package:e_commerce_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AccountCubit accountCubit;
  bool isObscure = true;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    accountCubit = getIt<AccountCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await accountCubit.getProfile();
    });
  }

  @override
  void dispose() {
    accountCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AccountCubit, AccountState>(
      bloc: accountCubit,
      listenWhen: (previous, current) =>
          current is GetProfileLoading ||
          current is GetProfileSuccess ||
          current is GetProfileError,
      buildWhen: (previous, current) => 
          current is GetProfileSuccess,
      listener: (context, state) {
        if (state is GetProfileLoading) {
          AppDialogs.showLoadingDialog(context, title: 'Loading Profile...');
        }
        if (state is GetProfileSuccess) {
          Navigator.of(context).pop(); // Close the loading dialog
        }
        if (state is GetProfileError) {
          Navigator.of(context).pop(); // Close the loading dialog
          AppToast.showToast(
            context: context,
            title: 'Error',
            description: state.message,
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          final profileResponseEntity = state.profileResponseEntity;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(width: size.width, height: size.height * 0.1),
                BlocConsumer<AccountCubit, AccountState>(
                  bloc: accountCubit,
                  listenWhen: (previous, current) => current is PickImageError,
                  buildWhen: (previous, current) => current is PickImageSuccess,
                  listener: (context, state) {
                    if (state is PickImageError) {
                      AppToast.showToast(
                        context: context,
                        title: 'Error',
                        description: state.message,
                        type: ToastificationType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PickImageSuccess) {
                      imageFile = state.imageFile;
                      return Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 110.r,
                              backgroundColor: AppColors.primary.withAlpha(150),
                            ),
                            CircleAvatar(
                              radius: 100.r,
                              backgroundImage: FileImage(File(imageFile!.path)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withAlpha(200),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.white,
                                    size: 30.r,
                                  ),
                                  onPressed: () async {
                                    await accountCubit.pickImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 110.r,
                            backgroundColor: AppColors.gray,
                          ),
                          CircleAvatar(
                            radius: 100.r,
                            backgroundImage:
                                profileResponseEntity.avatar.isNotEmpty
                                    ? CachedNetworkImageProvider(
                                        profileResponseEntity.avatar,
                                      )
                                    : const AssetImage(
                                            AppAssets.defaultUserProfileImage,
                                          )
                                          as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withAlpha(200),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.white,
                                  size: 30.r,
                                ),
                                onPressed: () async {
                                  await accountCubit.pickImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          profileResponseEntity.name,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          profileResponseEntity.email,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                          text: profileResponseEntity.password,
                        ),
                        // enabled: false,
                        obscureText: isObscure,
                        obscuringCharacter: '*',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2.r,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                BlocConsumer<AccountCubit, AccountState>(
                  bloc: accountCubit,
                  listenWhen: (previous, current) =>
                      current is UpdateUserProfileImageLoading ||
                      current is UpdateUserProfileImageSuccess ||
                      current is UpdateUserProfileImageError,
                  buildWhen: (previous, current) =>
                      current is UpdateUserProfileImageSuccess || 
                      current is PickImageSuccess,
                  listener: (context, state) {
                    if (state is UpdateUserProfileImageLoading) {
                      AppDialogs.showLoadingDialog(
                        context,
                        title: 'Updating Profile Image...',
                      );
                    }
                    if (state is UpdateUserProfileImageSuccess) {
                      Navigator.of(context).pop(); // Close the loading dialog
                      AppDialogs.showSnackBar(
                        context: context,
                        message: 'Updated user profile image successfully',
                      );
                    }
                    if (state is UpdateUserProfileImageError) {
                      Navigator.of(context).pop(); // Close the loading dialog
                      AppDialogs.showSnackBar(
                        context: context,
                        message: state.message,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PickImageSuccess) {
                      return MainButton(
                        text: 'Update Profile Image',
                        onPressed: () async {
                          await accountCubit.updateUserProfileImage(
                            UpdateUserProfileImageRequestEntity(
                              image: File(imageFile!.path),
                            ),
                          );
                        },
                      );
                    }
                    return MainButton(
                      text: 'Update Profile Image',
                      onPressed: null,
                    );
                  },
                ),
                SizedBox(height: 16.h),
                SecondaryButton(
                  text: 'Logout',
                  onPressed: () async {
                    await SecureStorage.clearTokens();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.login,
                        (route) => false,
                      );
                    }
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      } else {
          return const SizedBox.shrink(); // Return an empty widget for other states
        }
      },
    );
  }
}
