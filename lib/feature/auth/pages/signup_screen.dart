// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart';
import 'package:syrian_currency/feature/auth/logic/register/signup_cubit.dart';
import 'package:syrian_currency/feature/auth/logic/register/signup_state.dart';
import 'package:syrian_currency/feature/auth/widgets/sign_up_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Stack(
            children: [
              Positioned(top: -60, left: -60, child: _glow()),
              Positioned(bottom: -60, right: -60, child: _glow()),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 24.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(18.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: 1.sw,

                        color: AppColor.blureColor.withOpacity(0.4),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/svgs/logo.svg"),
                              SizedBox(height: 16.h),

                              Text(
                                "SYP Shield AI",
                                style: AppTextStyle.font30extraBold,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Secure your financial future with AI\nprotection",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.font16medium.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 32.h),
                              BlocConsumer<SignupCubit, SignupState>(
                                listener: (context, state) {
                                  if (state is SignupSuccess) {
                                    SnackBarHelper.showSuccess(
                                      context,
                                      "account created successfully",
                                    );
                                    context.pop();
                                  }
                                  if (state is SignupFailure) {
                                    SnackBarHelper.showError(
                                      context,
                                      state.errorMessage,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  bool isLoading = state is SignupLoading;
                                  return SignUpForm(
                                    cubit: cubit,
                                    formKey: formKey,
                                    isLoading: isLoading,
                                  );
                                },
                              ),
                              SizedBox(height: 32.h),
                              Divider(color: AppColor.gray, height: 0.1),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Already have an account? ",
                                      style: AppTextStyle.font16medium.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      child: Text(
                                        "Back to Login",
                                        style: AppTextStyle.font16medium
                                            .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blue,
                                            ),
                                      ),
                                      onTap: () => context.pop(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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

Widget _glow() {
  return Container(
    width: 170,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.00),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.15),
          blurRadius: 100,
          spreadRadius: 80,
        ),
      ],
    ),
  );
}
