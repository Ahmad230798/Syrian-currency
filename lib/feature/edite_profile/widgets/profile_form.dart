import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';
import 'package:syrian_currency/feature/edite_profile/logic/edite_profile_cubit.dart';

class ProfileForm extends StatelessWidget {
  final EditeProfileCubit cubit;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  const ProfileForm({
    super.key,
    required this.cubit,
    required this.formKey,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "First Name",
              style: AppTextStyle.font16medium.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            8.verticalSpace,
            AppTextFormField(
              controller: cubit.firstNameController,
              hinttText: "Enter your name",
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
      ),
    );
  }
}
