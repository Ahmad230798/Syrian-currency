import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ActivityCard extends StatelessWidget {
  final ScanDataModel scanHistory;
  const ActivityCard({super.key, required this.scanHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: AppColor.mainContainerBackGround,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.gray,
                backgroundImage: NetworkImage(scanHistory.image),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scan #${scanHistory.id.toString()}",
                      style: AppTextStyle.font14regular.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 20 / 14,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            scanHistory.status,
                            style: AppTextStyle.font12semibold.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ". ${_formatDate(scanHistory.createdAt)}",
                            style: AppTextStyle.font12semibold.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.grayText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              (scanHistory.status == "completed")
                  ? Icon(
                      Icons.check_circle_outline_outlined,
                      color: AppColor.green,
                    )
                  : Icon(Icons.cancel, color: AppColor.red),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(String rawDate) {
  try {
    // 🌟 1. تحويل وقت السيرفر (الذي يكون غالباً UTC) إلى التوقيت المحلي للهاتف
    DateTime date = DateTime.parse(rawDate).toLocal();
    DateTime now = DateTime.now();

    // 🌟 2. حساب الفارق الزمني بين الآن ووقت الفحص
    Duration diff = now.difference(date);

    // لتجنب أي أخطاء إذا كان وقت السيرفر متقدماً بثوانٍ قليلة عن الهاتف
    if (diff.isNegative) {
      return "Just now";
    }

    // 🌟 3. التحقق من الفارق الزمني وتحديد النص المناسب
    if (diff.inDays > 365) {
      int years = (diff.inDays / 365).floor();
      return "$years year${years == 1 ? '' : 's'} ago";
    } else if (diff.inDays > 30) {
      int months = (diff.inDays / 30).floor();
      return "$months month${months == 1 ? '' : 's'} ago";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago";
    } else {
      return "Just now"; // إذا كان الفارق أقل من دقيقة
    }
  } catch (e) {
    // كحل احتياطي إذا فشل التحويل
    return rawDate.length > 10 ? rawDate.substring(0, 10) : rawDate;
  }
}
