// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';

import 'widgets/project_hero_card.dart';
import 'widgets/executive_summary_card.dart';
import 'widgets/tech_stack_grid.dart';
import 'widgets/university_project_card.dart';

class AboutProjectScreen extends StatelessWidget {
  const AboutProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: const MyAppBar(title: 'Project Details', showRightIcon: false),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace,

                // 1. بطاقة الهيرو (الخلفية والصورة)
                const ProjectHeroCard(),

                24.verticalSpace,

                // 2. الملخص التنفيذي
                const ExecutiveSummaryCard(),

                24.verticalSpace,

                // 3. قسم التقنيات المستخدمة
                Text("Tech Stack", style: AppTextStyle.font18bold),
                16.verticalSpace,
                const TechStackGrid(),

                24.verticalSpace,

                // 4. بطاقة المشروع الجامعي
                const UniversityProjectCard(),

                32.verticalSpace, // مساحة فارغة في الأسفل
              ],
            ),
          ),
        ),
      ),
    );
  }
}
