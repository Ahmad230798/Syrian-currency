import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: AppTextStyle.font16medium.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            hinttText: "Majed Khalifa",
            prefixIcone: Icon(
              Icons.person_outline,
              color: AppColor.grayText,
              size: 22,
            ),
          ),
          24.verticalSpace,
          Text(
            "Email Address",
            style: AppTextStyle.font16medium.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            hinttText: "MajedKhalifa@gmail.com",
            prefixIcone: Icon(
              Icons.email_outlined,
              color: AppColor.grayText,
              size: 22,
            ),
          ),
          24.verticalSpace,
          Text(
            "Phone Number",
            style: AppTextStyle.font16medium.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            hinttText: "+09634107141",
            prefixIcone: Icon(
              Icons.phone_android_outlined,
              color: AppColor.grayText,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
