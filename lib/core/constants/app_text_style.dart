import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';

class AppTextStyle {
  static const font10bold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 15 / 10,
    letterSpacing: 1,
  );
  static const font12semibold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColor.blue,
    height: 16 / 12,
    letterSpacing: 0.6,
  );
  static const font14regular = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.grayText,
    height: 22.75 / 14,
    letterSpacing: 0,
  );

  static const font18bold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 24 / 16,
  );

  static const font16medium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.grayText,
    height: 24 / 16,
  );
  static const font20extrabold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 28 / 20,
  );
  static const font24bold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 32 / 24,
    letterSpacing: 0,
  );
  static const font30extraBold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 36 / 30,
  );
}
