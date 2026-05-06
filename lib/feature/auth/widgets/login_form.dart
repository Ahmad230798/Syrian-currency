import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/app_text_form_field.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  color: AppColore.blue,
                  height: 20 / 14,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
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
          SizedBox(height: 24.h),
          AppBottom(text: "Sign In"),
          
        ],
      ),
    );
  }
}
