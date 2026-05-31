import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/home/logic/home_cubit.dart';
import 'package:syrian_currency/feature/home/widget/activities_list.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              onTap: () {
                context.pushNamed(Routes.profile);
              },
              icon: Icons.person,
              title: 'Home',
              suffixsIcon: SvgPicture.asset("assets/svgs/app_bar_logo.svg"),
            ),
            BlocConsumer<HomeCubit, HomeState>(
              // 🌟 Listener: يراقب حالات الفحص دون تدمير الشاشة
              listener: (context, state) {
                if (state is ScanLoading) {
                  // إظهار نافذة تحميل منبثقة
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ScannerFailure) {
                  Navigator.pop(context); // إغلاق نافذة التحميل
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScannerSuccess) {
                  Navigator.pop(context); // إغلاق نافذة التحميل
                  // 🌟 هنا يمكنك الانتقال لشاشة النتيجة لاحقاً
                  // context.pushNamed(Routes.scanResult, arguments: state.successResponse);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Scan Successful!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },

              // 🌟 buildWhen: لحماية الشاشة من الاختفاء
              buildWhen: (previous, current) {
                return current is HomeLoading ||
                    current is HomeFailure ||
                    current is HomeSuccess;
              },

              // 🌟 Builder: يبني الشاشة بناءً على حالات السجل فقط
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: AppTextStyle.font14regular.copyWith(
                        color: AppColor.red,
                      ),
                    ),
                  );
                }
                if (state is HomeSuccess) {
                  final scanHistory = state.historyList;
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 24.h),
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(32.r),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22.w,
                                    vertical: 24.h,
                                  ),
                                  width: 1.sw,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.r),
                                    color: Color.fromRGBO(30, 50, 90, 120),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PROTECTION ACTIVATE",
                                        style: AppTextStyle.font12semibold
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.blue,
                                              letterSpacing: 1.2,
                                            ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        "Secure your digital\npresence",
                                        style: AppTextStyle.font24bold,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        "Our advanced AI engine detects deepfakes and\npotential content manipulation in seconds.",
                                        style: AppTextStyle.font14regular,
                                      ),
                                      SizedBox(height: 24.h),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            24.r,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/images/home_image.png",
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      AppBottom(
                                        onPressed: () {
                                          context.pushNamed(Routes.cameraScan);
                                        },
                                        text: "Start System Scan",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 22.h),
                            Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.r),
                                color: AppColor.mainContainerBackGround,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 20.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Instant Analysis",
                                          style: AppTextStyle.font18bold,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "Have an image? Upload it for an\ninstant security check.",
                                          style: AppTextStyle.font12semibold
                                              .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.grayText,
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  AppBottom(
                                    text: "Upload",
                                    boxShadow: [],
                                    color: AppColor.blue,
                                    backGroundColor: Color.fromRGBO(
                                      27,
                                      40,
                                      61,
                                      145,
                                    ),
                                    onPressed: () {
                                      cubit.pickImage();
                                    },
                                    textStyle: AppTextStyle.font14regular
                                        .copyWith(
                                          color: AppColor.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  SizedBox(width: 20.w),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ActivitiesList(
                              scanHistory: scanHistory,
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
