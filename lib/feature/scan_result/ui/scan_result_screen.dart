// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/scan_result/widgets/ai_confidence.dart';
import 'package:syrian_currency/feature/scan_result/widgets/authenticity.dart';
import 'package:syrian_currency/feature/scan_result/widgets/image_result.dart';
import 'package:syrian_currency/feature/scan_result/widgets/validation_points.dart';

class ScanResultScreen extends StatefulWidget {
  final ScanDataModel scanData; // استقبال داتا الفحص

  const ScanResultScreen({super.key, required this.scanData});

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

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabVisible) {
          setState(() => _isFabVisible = false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
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
        offset: _isFabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1.0 : 0.0,
          child: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: GestureDetector(
              onTap: () => context.pop(), // الرجوع للفحص مجدداً
              child: AppBottom(
                text: "Scan Again",
                icon: Icons.camera_outlined,
                // تأكد أن ويدجت AppBottom الخاص بك يقبل onTap أو استخدم GestureDetector كما فعلنا هنا
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(
              title: 'Scan Result',
              suffixsIcon: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColor.blureColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
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
                      ImageResult(scanData: widget.scanData),
                      24.verticalSpace,
                      Authenticity(scanData: widget.scanData),
                      16.verticalSpace,
                      AiConfidence(scanData: widget.scanData),
                      24.verticalSpace,
                      Text(
                        "Validation Points",
                        style: AppTextStyle.font12semibold.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grayText,
                        ),
                      ),
                      13.verticalSpace,
                      ValidationPoints(scanData: widget.scanData),
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
