import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AppBottom extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backGroundColor;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;
  final void Function()? onPressed;
  final bool? isLoading;
  final IconData? icon;
  final Color? textcolor;
  const AppBottom({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textStyle,
    this.backGroundColor,
    this.boxShadow,
    this.icon,
    this.textcolor,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: AppColor.blue,
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -4,
              ),
              BoxShadow(
                color: AppColor.shadowColor,
                offset: const Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backGroundColor ?? AppColor.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        ),
        onPressed: onPressed ?? () {},
        child: isLoading ?? false
            ? SizedBox(child: Center(child: CircularProgressIndicator()))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style:
                        textStyle ??
                        AppTextStyle.font18bold.copyWith(
                          color: textcolor ?? Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    icon ?? Icons.arrow_forward,
                    size: 25,
                    color: color ?? Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
