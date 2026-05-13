// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';

class AIExplanationScreen extends StatelessWidget {
  const AIExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: const MyAppBar(title: 'AI Analysis', showRightIcon: false),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                16.verticalSpace,

                // 1. صورة الفحص (Hero Analysis Image)
                _buildHeroImage(),

                32.verticalSpace,

                // 2. حالة الفحص (Analysis Complete) مطابقة للصورة
                _buildStatusSection(),

                32.verticalSpace,

                // 3. بطاقة تحليل الذكاء الاصطناعي (AI Logic Card) مطابقة للصورة
                _buildAILogicCard(),

                16.verticalSpace,

                // 4. المقاييس التفصيلية (Detailed Metrics)
                _buildDetailedMetrics(),

                32.verticalSpace,
              ],
            ),
          ),
        ),
        // 5. الأزرار السفلية (Footer Actions)
        bottomNavigationBar: _buildFooterActions(),
      ),
    );
  }

  // --- دوال بناء أقسام الصفحة ---

  Widget _buildHeroImage() {
    return Container(
      width: double.infinity,
      height: 223.75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/syp.jpg"), // تأكد من المسار
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // تظليل خفيف جداً
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // دائرة الفحص الزرقاء في المنتصف
          Center(
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.blue.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
            ),
          ),
          // الشارة السفلية (SYP Shield AI)
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: Row(
              children: [
                const Icon(Icons.verified, color: AppColor.blue, size: 20),
                8.horizontalSpace,
                Text(
                  "SYP Shield AI",
                  style: AppTextStyle.font18bold.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      children: [
        Text(
          "Analysis Complete",
          style: AppTextStyle.font24bold.copyWith(fontSize: 30),
        ),
        8.verticalSpace,
        Text(
          "Model focused on security thread and\nmicro-pattern regions.",
          textAlign: TextAlign.center,
          style: AppTextStyle.font18bold.copyWith(
            color: AppColor.grayText,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAILogicCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصندوق الداخلي للأيقونة (كما في الصورة)
          Container(
            width: double.infinity,
            height: 360.h,
            decoration: BoxDecoration(
              color: AppColor.blureColor, // لون أغمق بقليل
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.psychology, color: AppColor.blue, size: 55.sp),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.backGroundColor,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          20.verticalSpace,

          // العناوين (HIGH CONFIDENCE و ID)
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "HIGH CONFIDENCE",
                  style: AppTextStyle.font10bold.copyWith(color: AppColor.blue),
                ),
              ),
              12.horizontalSpace,
              Text(
                "ID: SYP-8842-X",
                style: AppTextStyle.font10bold.copyWith(
                  color: AppColor.grayText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          16.verticalSpace,

          Text(
            "AI Detection Logic",
            style: AppTextStyle.font18bold.copyWith(fontSize: 20),
          ),

          12.verticalSpace,

          Text(
            "The neural network identified high-confidence markers in the holographic strip and intaglio printing areas. Comparison against known reference models shows zero variance.",
            style: AppTextStyle.font16medium.copyWith(height: 1.6),
          ),

          24.verticalSpace,

          // التقييم وزر التفاصيل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "99.8%",
                    style: AppTextStyle.font24bold.copyWith(
                      color: AppColor.blue,
                    ),
                  ),
                  Text(
                    "CONFIDENCE SCORE",
                    style: AppTextStyle.font10bold.copyWith(
                      color: AppColor.grayText,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue,
                  foregroundColor: Colors.white,
                  elevation: 0, // بدون ظل مزعج
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
                icon: const Icon(Icons.visibility_outlined, size: 16),
                label: Text(
                  "View Heatmap\nDetails",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14regular.copyWith(
                    color: Colors.white,
                    letterSpacing: 0,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedMetrics() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricItem(
            icon: Icons.fingerprint,
            title: "Micro-patterns",
            value: "Authentic Match",
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: _buildMetricItem(
            icon: Icons.texture,
            title: "Paper Texture",
            value: "Verified Fiber",
          ),
        ),
      ],
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.blue, size: 24.sp),
          16.verticalSpace,
          Text(
            title.toUpperCase(),
            style: AppTextStyle.font10bold.copyWith(color: AppColor.grayText),
          ),
          6.verticalSpace,
          Text(
            value,
            style: AppTextStyle.font14regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // تم التعديل لتكون مطابقة تماماً للأزرار في الصورة (بدون أيقونات سهم)
  Widget _buildFooterActions() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 24.h,
        top: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.backGroundColor,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainContainerBackGround,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                "Generate Report",
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                "Start New Scan",
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
