// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ScanCard extends StatelessWidget {
  final ScanDataModel scanData;

  const ScanCard({super.key, required this.scanData});

  String _formatDate(String isoDate) {
    DateTime date = DateTime.parse(isoDate).toLocal();
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return "$day/$month/${date.year} • $hour:$minute";
  }

  String _getImageUrl() {
    // 👈 التعديل هنا: استخدام الصورة الأصلية للمستخدم بدلاً من الـ heatmap
    String path = scanData.image;
    if (path.startsWith("http")) {
      return path;
    }
    return "http://192.168.1.5:8000$path"; // 👈 تأكد أن الـ IP يطابق سيرفرك الحالي
  }

  @override
  Widget build(BuildContext context) {
    bool isGenuine = scanData.isGenuine;
    Color resultColor = isGenuine ? AppColor.green : AppColor.red;
    String resultText = isGenuine ? "GENUINE" : "COUNTERFEIT";

    return Column(
      children: [
        OptionsCard(
          // 👈 التعديل هنا: إضافة خاصية الانتقال عند الضغط
          onTap: () {
            context.pushNamed(
              Routes.scanResult,
              arguments: {
                'scanData': scanData,
                'isExpert': false, // مستخدم عادي
              },
            );
          },
          widget: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(_getImageUrl()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          mainWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SYP Scan  •  ID #${scanData.id}",
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _formatDate(scanData.createdAt),
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColor.grayText,
                ),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: resultColor),
                  4.horizontalSpace,
                  Text(
                    resultText,
                    style: AppTextStyle.font10bold.copyWith(color: resultColor),
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
