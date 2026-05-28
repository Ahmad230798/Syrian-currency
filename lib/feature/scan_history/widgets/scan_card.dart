// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ScanCard extends StatelessWidget {
  final ScanDataModel scanData;

  const ScanCard({super.key, required this.scanData});

  // دالة بسيطة لتنسيق التاريخ والوقت
  String _formatDate(String isoDate) {
    DateTime date = DateTime.parse(isoDate).toLocal();
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return "$day/$month/${date.year} • $hour:$minute";
  }

  // دالة ذكية لمعالجة الرابط (تمنع تكرار http://)
  String _getImageUrl() {
    String path = scanData.heatmap ?? scanData.image;
    if (path.startsWith("http")) {
      return path; // الرابط كامل وجاهز
    }
    return "http://192.168.1.14:8000$path"; // الرابط يحتاج إضافة الدومين
  }

  @override
  Widget build(BuildContext context) {
    bool isGenuine = scanData.isGenuine;
    Color resultColor = isGenuine ? AppColor.green : AppColor.red;
    String resultText = isGenuine ? "GENUINE" : "COUNTERFEIT";

    return Column(
      children: [
        OptionsCard(
          widget: Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  _getImageUrl(),
                ), // استخدمنا الدالة الذكية هنا
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
