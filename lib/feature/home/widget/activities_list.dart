import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/home/logic/home_cubit.dart';
import 'package:syrian_currency/feature/home/widget/activity_card.dart';

class ActivitiesList extends StatelessWidget {
  final List<ScanDataModel> scanHistory;
  final HomeCubit cubit;
  const ActivitiesList({
    super.key,
    required this.scanHistory,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Recent Activity", style: AppTextStyle.font18bold),
            Spacer(),
            if (scanHistory.length > 3)
              InkWell(
                onTap: cubit.toggleMoreState,
                child: Text(
                  // 🌟 تغيير النص ديناميكياً بناءً على الحالة
                  cubit.more ? "Show Less" : "View All",
                  style: AppTextStyle.font12semibold,
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          itemCount: cubit.more
              ? scanHistory.length
              : min(scanHistory.length, 3),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ActivityCard(scanHistory: scanHistory[index]);
          },
        ),
      ],
    );
  }
}
