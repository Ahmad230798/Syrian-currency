// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:ui'; // 👈 أضفناها من أجل تأثير الـ Blur (BackdropFilter)
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 👈 ضرورية للـ BlocConsumer
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart'; // 👈 ضرورية لرسائل النجاح والخطأ
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/scan_result/widgets/ai_confidence.dart';
import 'package:syrian_currency/feature/scan_result/widgets/authenticity.dart';
import 'package:syrian_currency/feature/scan_result/widgets/image_result.dart';
import 'package:syrian_currency/feature/scan_result/widgets/validation_points.dart';

// 👈 تأكد من تعديل هذه المسارات لتطابق مجلداتك إذا كانت مختلفة
import '../logic/feedback_cubit.dart';
import '../logic/feedback_state.dart';

class ScanResultScreen extends StatefulWidget {
  final ScanDataModel scanData;
  final bool isExpert; // 👈 متغير تحديد صلاحية الخبير

  const ScanResultScreen({
    super.key,
    required this.scanData,
    this.isExpert = false,
  });

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
        if (_isFabVisible) setState(() => _isFabVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isFabVisible) setState(() => _isFabVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // =================================================================
  // 👈 دالة إظهار نافذة إرسال التقرير (Expert Override)
  // =================================================================
  void _showReportDialog(BuildContext context, int scanId) {
    final feedbackCubit = context.read<FeedbackCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  20,
                  15,
                  15,
                  0.95,
                ), // لون داكن مائل للاحمرار
                border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.report_problem,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                      12.horizontalSpace,
                      Text(
                        "Expert Override",
                        style: AppTextStyle.font18bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    "Please provide technical justification for overriding the DeepCAE AI verdict. This report will be audited.",
                    style: AppTextStyle.font12semibold.copyWith(
                      color: AppColor.grayText,
                      height: 1.5,
                    ),
                  ),
                  24.verticalSpace,

                  // حقل الإدخال النصي
                  TextField(
                    controller: feedbackCubit.noteController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter anomaly details...",
                      hintStyle: TextStyle(
                        color: AppColor.grayText.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.redAccent.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  32.verticalSpace,

                  // الاستماع لحالة الإرسال (زر التحميل / النجاح)
                  BlocConsumer<FeedbackCubit, FeedbackState>(
                    bloc: feedbackCubit, // تمرير الكيوبت صراحة للـ Dialog
                    listener: (context, state) {
                      if (state is FeedbackSuccess) {
                        Navigator.pop(dialogContext); // إغلاق النافذة
                        SnackBarHelper.showSuccess(
                          context,
                          "Report escalated to Admin successfully.",
                        );
                      } else if (state is FeedbackError) {
                        SnackBarHelper.showError(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is FeedbackLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                feedbackCubit.noteController.clear();
                                Navigator.pop(dialogContext);
                              },
                              child: Text(
                                "Cancel",
                                style: AppTextStyle.font14regular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: () =>
                                  feedbackCubit.submitReport(scanId),
                              child: Text(
                                "Submit Report",
                                style: AppTextStyle.font14regular.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              onTap: () => context.pop(),
              child: AppBottom(text: "Scan Again", icon: Icons.camera_outlined),
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
                      // 👈 تمرير الـ isExpert للويدجت هنا!
                      ImageResult(
                        scanData: widget.scanData,
                        isExpert: widget.isExpert,
                      ),
                      24.verticalSpace,
                      Authenticity(scanData: widget.scanData),
                      16.verticalSpace,
                      AiConfidence(
                        scanData: widget.scanData,
                        isExpert: widget.isExpert,
                      ),
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

                      // لوحة تحكم الخبير
                      if (widget.isExpert) ...[
                        24.verticalSpace,
                        _buildExpertPanel(context),
                        100.verticalSpace,
                      ] else ...[
                        100.verticalSpace,
                      ],
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

  // تصميم لوحة الخبير (أزرار التقرير والتصدير)
  Widget _buildExpertPanel(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.05),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.science, color: Colors.purpleAccent),
              8.horizontalSpace,
              Text(
                "Expert Tools",
                style: AppTextStyle.font16medium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.2),
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    _showReportDialog(context, widget.scanData.id);
                  },
                  icon: const Icon(Icons.report_problem_outlined, size: 20),
                  label: Text(
                    "Report Error",
                    style: AppTextStyle.font12semibold.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue.withOpacity(0.2),
                    foregroundColor: AppColor.blue,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Export Data
                    print("تصدير التقرير");
                  },
                  icon: const Icon(Icons.download, size: 20),
                  label: Text(
                    "Export Data",
                    style: AppTextStyle.font12semibold.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
