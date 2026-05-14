// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/scan_result/widgets/ai_confidence.dart';
import 'package:syrian_currency/feature/scan_result/widgets/authenticity.dart';
import 'package:syrian_currency/feature/scan_result/widgets/image_result.dart';
import 'package:syrian_currency/feature/scan_result/widgets/validation_points.dart';

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({super.key});

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  late ScrollController _scrollController;
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // 3. مراقبة حركة التمرير
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // التمرير لأسفل -> إخفاء الزر
        if (_isFabVisible) {
          setState(() => _isFabVisible = false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // التمرير لأعلى -> إظهار الزر
        if (!_isFabVisible) {
          setState(() => _isFabVisible = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isFabVisible
            ? Offset.zero
            : const Offset(0, 2), // ينزلق للأسفل عند الإخفاء
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1.0 : 0.0,
          child: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: AppBottom(text: "Scan Again", icon: Icons.camera_outlined),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              title: 'Scan Result',
              suffixsIcon: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColor.blureColor.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            17.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageResult(),
                      24.verticalSpace,
                      Authenticity(),
                      16.verticalSpace,
                      AiConfidence(),
                      24.verticalSpace,
                      Text(
                        "Validation Points",
                        style: AppTextStyle.font12semibold.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grayText,
                        ),
                      ),
                      13.verticalSpace,
                      ValidationPoints(),
                      100.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
