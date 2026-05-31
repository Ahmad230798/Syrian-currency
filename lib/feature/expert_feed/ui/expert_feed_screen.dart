// ignore_for_file: deprecated_member_use, unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';

import '../logic/expert_feed_cubit.dart';
import '../logic/expert_feed_state.dart';

class ExpertFeedScreen extends StatelessWidget {
  final bool isFromBottomNav;
  const ExpertFeedScreen({super.key, this.isFromBottomNav = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // لأنها ستكون داخل الـ IndexedStack
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "Community Scans",
              showRightIcon: false,
              onBackTap: isFromBottomNav ? null : () => context.pop(),
              suffixsIcon: isFromBottomNav
                  ? const SizedBox.shrink() // إخفاء زر الرجوع إذا كانت في التاب السفلي
                  : null,
            ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Audit recent user scans. Help us train the AI by reporting anomalies.",
                style: AppTextStyle.font14regular.copyWith(
                  color: AppColor.grayText,
                ),
              ),
            ),
            16.verticalSpace,
            Expanded(
              child: BlocBuilder<ExpertFeedCubit, ExpertFeedState>(
                builder: (context, state) {
                  if (state is ExpertFeedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.blue),
                    );
                  } else if (state is ExpertFeedError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else if (state is ExpertFeedSuccess) {
                    if (state.scans.isEmpty) {
                      return Center(
                        child: Text(
                          "No community scans available.",
                          style: AppTextStyle.font16medium.copyWith(
                            color: AppColor.grayText,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColor.blue,
                      backgroundColor: AppColor.mainContainerBackGround,
                      onRefresh: () async =>
                          context.read<ExpertFeedCubit>().fetchFeed(),
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          bottom: 100.h,
                        ),
                        itemCount: state.scans.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final scan = state.scans[index];
                          final isGenuine =
                              scan.result.toLowerCase() == 'genuine';
                          final color = isGenuine
                              ? AppColor.green
                              : Colors.redAccent;

                          // صورة مصغرة (نعرض الأصلية للتشويق)
                          const String baseUrl =
                              "http://192.168.1.14:8000"; // عدل الـ IP إذا لزم
                          final String img = scan.image.startsWith('http')
                              ? scan.image
                              : "$baseUrl${scan.image}";

                          return InkWell(
                            borderRadius: BorderRadius.circular(16.r),
                            onTap: () {
                              // 👈 السحر هنا: نرسل الخبير لشاشة النتائج بصلاحياته!
                              context.pushNamed(
                                Routes.scanResult,
                                arguments: {
                                  'scanData': scan,
                                  'isExpert': true, // تفعيل أدوات الخبير!
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColor.mainContainerBackGround,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // صورة الفحص
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.network(
                                      img,
                                      width: 70.w,
                                      height: 70.w,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 70.w,
                                        height: 70.w,
                                        color: Colors.black26,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: AppColor.grayText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  // التفاصيل
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Scan #${scan.id}",
                                          style: AppTextStyle.font16medium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                        ),
                                        4.verticalSpace,
                                        Text(
                                          scan.createdAt.substring(0, 10),
                                          style: AppTextStyle.font12semibold
                                              .copyWith(
                                                color: AppColor.grayText,
                                              ),
                                        ),
                                        8.verticalSpace,
                                        Row(
                                          children: [
                                            Icon(
                                              isGenuine
                                                  ? Icons.verified
                                                  : Icons.warning_amber_rounded,
                                              size: 14.sp,
                                              color: color,
                                            ),
                                            4.horizontalSpace,
                                            Text(
                                              scan.result.toUpperCase(),
                                              style: AppTextStyle.font10bold
                                                  .copyWith(color: color),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // زر التدقيق
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.sp,
                                    color: AppColor.grayText,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
