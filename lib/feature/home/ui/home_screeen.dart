// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
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
              listener: (context, state) {
                if (state is ScanLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Material(
                      type: MaterialType.transparency,
                      child: SmartLoadingOverlay(),
                    ),
                  );
                } else if (state is ScannerFailure) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScannerSuccess) {
                  Navigator.pop(context);

                  if (state.response.data != null) {
                    context.pushNamed(
                      Routes.scanResult,
                      arguments: {
                        'scanData': state.response.data,
                        'isExpert': false,
                      },
                    );
                  }
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();

                if (state is HomeLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: AppColor.blue),
                    ),
                  );
                }

                if (state is HomeFailure) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTextStyle.font14regular.copyWith(
                          color: AppColor.red,
                        ),
                      ),
                    ),
                  );
                }

                // 🌟 الحل هنا: استخراج البيانات إذا كانت متوفرة، أو إعطاء قيم افتراضية للزائر (HomeInitial)
                List<ScanDataModel> scanHistory = [];
                bool isMoreData = false;

                if (state is HomeSuccess) {
                  scanHistory = state.historyList;
                  isMoreData = state.isMore;
                }

                // الرسم يتم دائماً سواء كان المستخدم User أو Guest
                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),

                          // 🌟 التنبيه الذكي للزوار (يظهر فقط للزائر)
                          FutureBuilder<String>(
                            future: SharedPreferencesService().getUserRole(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == 'guest') {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 24.h),
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent.withOpacity(0.1),
                                    border: Border.all(
                                      color: Colors.orangeAccent.withOpacity(
                                        0.5,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.orangeAccent,
                                        size: 28.sp,
                                      ),
                                      16.horizontalSpace,
                                      Expanded(
                                        child: Text(
                                          "As a guest, you are allowed only 2 free analyses.",
                                          style: AppTextStyle.font14regular
                                              .copyWith(
                                                color: Colors.orangeAccent,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),

                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(32.r),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 24.h,
                                ),
                                width: 1.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32.r),
                                  color: const Color.fromRGBO(30, 50, 90, 120),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                const Spacer(),
                                AppBottom(
                                  text: "Upload",
                                  boxShadow: const [],
                                  color: AppColor.blue,
                                  backGroundColor: const Color.fromRGBO(
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

                          // إخفاء الـ History للزوار وعرضه للمسجلين
                          if (scanHistory.isNotEmpty || state is HomeSuccess)
                            ActivitiesList(
                              scanHistory: scanHistory,
                              cubit: cubit,
                              isMore: isMoreData,
                            ),

                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SmartLoadingOverlay extends StatefulWidget {
  const SmartLoadingOverlay({super.key});

  @override
  State<SmartLoadingOverlay> createState() => _SmartLoadingOverlayState();
}

class _SmartLoadingOverlayState extends State<SmartLoadingOverlay> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> _messages = [
    "Uploading Image...",
    "Initializing SYP SHIELD AI...",
    "Running DeepCAE Anomaly Detection...",
    "Extracting security features...",
    "Analyzing Grad-CAM Heatmaps...",
    "This process may take up to 90 seconds.\nPlease do not close the app...",
    "Finalizing results...",
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 12), (timer) {
      if (mounted) {
        setState(() {
          if (_currentIndex < _messages.length - 1) {
            _currentIndex++;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.75),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColor.blue),
                32.verticalSpace,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _messages[_currentIndex],
                    key: ValueKey<int>(_currentIndex),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font16medium.copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
