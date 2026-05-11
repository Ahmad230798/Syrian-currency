import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class Authenticity extends StatelessWidget {
  const Authenticity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Text(
                "AUTHENTICITY",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.grayText,
                ),
              ),
              16.verticalSpace,
              Container(
                width: 64.w,
                height: 64.h,
    
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.green.withOpacity(0.2),
                  border: Border.all(
                    strokeAlign: 1,
                    color: AppColor.green.withOpacity(0.3),
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.verified_outlined,
                    color: AppColor.green.withOpacity(1),
                    size: 33,
                  ),
                ),
              ),
              8.verticalSpace,
              Text(
                "GENUINE",
                style: AppTextStyle.font24bold.copyWith(
                  color: AppColor.green,
                ),
              ),
              16.verticalSpace,
              Text(
                "All security features match federal reserve\nstandards",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.grayText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
