// ignore_for_file: must_be_immutable
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  bool obscureText;
  final bool isPassword;
  final bool isFullName;
  final bool isSearch;
  final VoidCallback? searchOnPressed;
  final TextEditingController controller;
  final String? Function(String?) validator;

  TextFormFieldWidget({
    required this.controller,
    required this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    this.isFullName = false,
    this.isSearch = false,
    this.searchOnPressed,
    super.key,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontFamily: "Almarai",
        fontSize: 16.sp,
        fontWeight: !widget.isSearch ? FontWeight.w600 : FontWeight.w400,
        color: AppColors.black.withAlpha(200),
      ),
      obscureText: widget.obscureText,
      obscuringCharacter: '*',
      cursorColor: AppColors.black,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        filled: widget.isSearch ? false : true,
        fillColor: AppColors.background,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.r),
        ),
        hintStyle: TextStyle(
          fontFamily: "Almarai",
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: widget.isSearch
              ? AppColors.gray
              : AppColors.black.withAlpha(150),
          overflow: TextOverflow.ellipsis,
        ),
        // prefixIcon: widget.isPassword
        //     ? Padding(
        //         padding: EdgeInsets.all(8.r),
        //         child: SvgPicture.asset(AppAssets.passwordIcon),
        //       )
        //     : widget.isFullName
        //     ? Padding(
        //         padding: EdgeInsets.all(8.r),
        //         child: Icon(Icons.person_outline, size: 32.sp),
        //       )
        //     : widget.isSearch
        //     ? null
        //     : Padding(
        //         padding: EdgeInsets.all(8.r),
        //         child: SvgPicture.asset(AppAssets.emailIcon),
        //       ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: Icon(
                  widget.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              )
            : widget.isSearch
            ? GestureDetector(
                onTap: widget.searchOnPressed,
                child: SvgPicture.asset(
                  AppAssets.searchIcon,
                  width: 24.sp,
                  height: 24.sp,
                ),
              )
            : null,

        // contentPadding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        // enabledBorder: outlineInputBorder(
        //   color: Color(0xffBABABA),
        //   radius: 10,
        //   width: 1,
        // ),
        focusedBorder: !widget.isSearch
            ? null
            : outlineInputBorder(
                color: AppColors.primary,
                radius: 12.r,
                width: 1.r,
              ),
        // errorBorder: outlineInputBorder(
        //   color: Colors.red,
        //   radius: 10,
        //   width: 1,
        // ),
        // focusedErrorBorder: outlineInputBorder(
        //   color: Colors.red,
        //   radius: 10,
        //   width: 1,
        // ),
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
    );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
