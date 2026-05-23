// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/validator.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';
import 'package:syrian_currency/feature/auth/logic/register/signup_cubit.dart';
import 'package:syrian_currency/feature/auth/model/signup_model/signup_request_body.dart';

class SignUpForm extends StatelessWidget {
  final SignupCubit cubit;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  const SignUpForm({
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
            "Full Name",
            style: AppTextStyle.font12semibold.copyWith(
              fontSize: 14,
              color: Colors.white,
              height: 20 / 14,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8),
          AppTextFormField(
            hinttText: "Enter Your Name",
            controller: cubit.fullNameController,
            prefixIcone: Icon(Icons.person_outline_sharp, color: Colors.white),
            validator: Validators().fullNameValidator,
          ),
          SizedBox(height: 15),
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
            controller: cubit.emailController,
            prefixIcone: Icon(Icons.mail_outline, color: Colors.white),
            validator: Validators().emailValidator,
          ),
          SizedBox(height: 15.h),
          Text(
            "Passwords",
            style: AppTextStyle.font12semibold.copyWith(
              fontSize: 14,
              color: Colors.white,
              height: 20 / 14,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 15),
          AppTextFormField(
            hinttText: "••••••••",

            controller: cubit.passwordController,
            isObscureText: cubit.isObscureText,
            prefixIcone: Icon(Icons.lock_outline, color: Colors.white),
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
            text: "Create Account",
            isLoading: isLoading,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                cubit.signUp(
                  SignupRequestBody(
                    email: cubit.emailController.text,
                    fullName: cubit.fullNameController.text,
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
