import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AppTextFormField extends StatelessWidget {
  final Color? fillColor;
  final Color? focusColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? hintStyle;
  final String hinttText;
  final bool? isObscureText;
  final Widget? suffixIcone;
  final Widget? prefixIcone;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? linesCount;
  final bool? isFilled;
  const AppTextFormField({
    super.key,
    required this.hinttText,
    this.isObscureText,
    this.suffixIcone,
    this.onChanged,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    this.controller,
    this.validator,
    this.linesCount,
    this.fillColor,
    this.focusColor,
    this.isFilled,
    this.prefixIcone,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: (isObscureText ?? false) ? 1 : (linesCount ?? 1),
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: isFilled,
        fillColor: fillColor,

        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.grayText,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.gray, width: 1.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintStyle:
            hintStyle ??
            AppTextStyle.font16medium.copyWith(fontWeight: FontWeight.w400),
        hintText: hinttText,
        suffixIcon: suffixIcone,
        prefixIcon: prefixIcone,
      ),
      obscureText: isObscureText ?? false,
      style: AppTextStyle.font16medium.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
