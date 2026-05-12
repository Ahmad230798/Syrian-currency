import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';

class ScanCard extends StatelessWidget {
  final String? result;
  final Color? color;
  const ScanCard({super.key, this.result, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionsCard(
          widget: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColor.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
          mainWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rolex Submariner 126610",
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Today • 14:22",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColor.grayText,
                ),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: color ?? AppColor.green),
                  4.horizontalSpace,
                  Text(
                    result ?? "GENUINE",
                    style: AppTextStyle.font10bold.copyWith(
                      color: color ?? AppColor.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
