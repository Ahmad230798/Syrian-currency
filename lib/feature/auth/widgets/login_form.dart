// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/validator.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';
import 'package:syrian_currency/feature/auth/logic/login/login_cubit.dart';
import 'package:syrian_currency/feature/auth/model/login_model/login_request_body.dart';

class LogInForm extends StatelessWidget {
  final LoginCubit cubit;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  const LogInForm({
    super.key,
    required this.cubit,
    required this.formKey,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Address",
            style: AppTextStyle.font12semibold.copyWith(
              fontSize: 14,
              color: Colors.white,
              height: 20 / 14,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8),
          AppTextFormField(
            hinttText: "name@example.com",
            prefixIcone: Icon(Icons.mail_outline, color: Colors.white),
            validator: Validators().emailValidator,
            controller: cubit.emailController,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Text(
                "Passwords",
                style: AppTextStyle.font12semibold.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  height: 20 / 14,
                  letterSpacing: 0,
                ),
              ),
              Spacer(),
              Text(
                "Forgot Password?",
                style: AppTextStyle.font12semibold.copyWith(
                  fontSize: 14,
                  color: AppColor.blue,
                  height: 20 / 14,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          AppTextFormField(
            hinttText: "••••••••",
            isObscureText: cubit.isObscureText,
            prefixIcone: Icon(Icons.lock_outline, color: Colors.white),
            controller: cubit.passwordController,
            suffixIcone: InkWell(
              onTap: () {
                cubit.togglePasswordVisibility();
              },
              child: Icon(
                cubit.isObscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ),
            validator: Validators().passwordValidator,
          ),
          SizedBox(height: 24.h),
          AppBottom(
            isLoading: isLoading,
            text: "Sign In",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.login(
                  LoginRequestBody(
                    email: cubit.emailController.text,
                    password: cubit.passwordController.text,
                  ),
                );
             
              }
            },
          ),
        ],
      ),
    );
  }
}
