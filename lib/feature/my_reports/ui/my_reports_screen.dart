// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';

import '../logic/my_reports_cubit.dart';
import '../logic/my_reports_state.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "My Reports",
              showRightIcon: false,
              onBackTap: () => context.pop(),
            ),
            16.verticalSpace,
            Expanded(
              child: BlocBuilder<MyReportsCubit, MyReportsState>(
                builder: (context, state) {
                  if (state is MyReportsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.blue),
                    );
                  } else if (state is MyReportsError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else if (state is MyReportsSuccess) {
                    if (state.reports.isEmpty) {
                      return Center(
                        child: Text(
                          "You haven't submitted any reports yet.",
                          style: AppTextStyle.font14regular.copyWith(
                            color: AppColor.grayText,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColor.blue,
                      backgroundColor: AppColor.mainContainerBackGround,
                      onRefresh: () async =>
                          context.read<MyReportsCubit>().fetchMyReports(),
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          bottom: 40.h,
                        ),
                        itemCount: state.reports.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final report = state.reports[index];

                          // تحديد لون وحالة التقرير
                          Color statusColor = Colors.orangeAccent;
                          IconData statusIcon = Icons.hourglass_empty;
                          if (report.status.toLowerCase() == 'resolved') {
                            statusColor = AppColor.green;
                            statusIcon = Icons.check_circle;
                          } else if (report.status.toLowerCase() ==
                              'rejected') {
                            statusColor = Colors.redAccent;
                            statusIcon = Icons.cancel;
                          } else if (report.status.toLowerCase() ==
                              'reviewed') {
                            statusColor = AppColor.blue;
                            statusIcon = Icons.remove_red_eye;
                          }

                          return Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColor.mainContainerBackGround,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Report #${report.id}",
                                      style: AppTextStyle.font16medium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        border: Border.all(
                                          color: statusColor.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            statusIcon,
                                            size: 14.sp,
                                            color: statusColor,
                                          ),
                                          6.horizontalSpace,
                                          Text(
                                            report.status.toUpperCase(),
                                            style: AppTextStyle.font10bold
                                                .copyWith(color: statusColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                8.verticalSpace,
                                Text(
                                  "Scan Reference: #${report.scan}",
                                  style: AppTextStyle.font12semibold.copyWith(
                                    color: AppColor.grayText,
                                  ),
                                ),
                                16.verticalSpace,
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    report.note ?? "No details provided.",
                                    style: AppTextStyle.font14regular.copyWith(
                                      color: Colors.white,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                Text(
                                  "Submitted on: ${report.createdAt.substring(0, 10)}",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                  ),
                                ),
                              ],
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
