import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObscureText = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
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
            prefixIcone: Icon(Icons.person_outline_sharp, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username is required";
              }
              if (value.length < 3) {
                return "Username must be at least 3 characters";
              }
              return null;
            },
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
            prefixIcone: Icon(Icons.mail_outline, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }

              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return "Enter a valid email";
              }

              return null;
            },
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
            isObscureText: isObscureText,
            prefixIcone: Icon(Icons.lock_outline, color: Colors.white),
            suffixIcone: InkWell(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }

              return null;
            },
          ),
          SizedBox(height: 15),

          Text(
            "Confirm Passwoord",
            style: AppTextStyle.font12semibold.copyWith(
              fontSize: 14,
              color: Colors.white,
              height: 20 / 14,
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 8),
          AppTextFormField(
            hinttText: "••••••••",

            prefixIcone: Icon(Icons.lock_outline, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          AppBottom(
            text: "Create Account",
            isLoading: isLoading,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                  Future.delayed(Duration(seconds: 3), () {
                    context.pushNamedAndRemoveUntil(Routes.logIn);
                  });
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
