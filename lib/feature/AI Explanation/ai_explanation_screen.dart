import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'widgets/hero_analysis_image.dart';
import 'widgets/analysis_status_section.dart';
import 'widgets/ai_logic_card.dart';
import 'widgets/detailed_metrics_section.dart';
import 'widgets/footer_actions.dart';

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

                const HeroAnalysisImage(), // 1. صورة الفحص

                32.verticalSpace,

                const AnalysisStatusSection(), // 2. حالة الفحص

                32.verticalSpace,

                const AILogicCard(), // 3. بطاقة تحليل الذكاء الاصطناعي

                16.verticalSpace,

                const DetailedMetricsSection(), // 4. المقاييس التفصيلية

                32.verticalSpace,
              ],
            ),
          ),
        ),
        bottomNavigationBar: const FooterActions(), // 5. الأزرار السفلية
      ),
    );
  }
}
