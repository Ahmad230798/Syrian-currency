import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';

class AppTextStyle {
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
    color: AppColore.grayText,
    height: 24 / 16,
  );
  static const font12semibold = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColore.blue,
    height: 16 / 12,
    letterSpacing: 0.6,
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
