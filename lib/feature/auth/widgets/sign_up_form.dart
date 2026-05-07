import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
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
          ),
          SizedBox(height: 24.h),
          AppBottom(text: "Create Account"),
        ],
      ),
    );
  }
}
