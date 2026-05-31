// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/core/networking/dio_factory.dart';
import 'package:syrian_currency/feature/home/logic/home_cubit.dart';
import 'package:syrian_currency/feature/home/repo/home_repo.dart';

// استدعاء شاشاتك الفعلية
import 'package:syrian_currency/feature/home/ui/home_screeen.dart';
import 'package:syrian_currency/feature/scan_history/logic/scan_history_cubit.dart';
import 'package:syrian_currency/feature/scan_history/repo/scan_history_repo.dart';
import 'package:syrian_currency/feature/scan_history/ui/scan_history_screen.dart';
import 'package:syrian_currency/feature/profile/logic/profile_cubit.dart';
import 'package:syrian_currency/feature/profile/repo/profile_repo.dart';
import 'package:syrian_currency/feature/profile/ui/profile_screen.dart';
import 'package:syrian_currency/feature/settings_screen/logic/setting_cubit.dart';
import 'package:syrian_currency/feature/settings_screen/repo/setting_repo.dart';
import 'package:syrian_currency/feature/settings_screen/ui/settings_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (context) => HomeCubit(
          HomeRepo(
            ApiServices(DioFactory.getDio()),
            SharedPreferencesService(),
          ),
        )..getScanHistory(),
        child: const HomeScreeen(),
      ),

      // 👈 تم التعديل هنا لربط الـ Cubit
      BlocProvider(
        create: (context) =>
            ScanHistoryCubit(ScanHistoryRepo(ApiServices(DioFactory.getDio())))
              ..fetchHistory(), // يتم استدعاء البيانات فور بناء الشاشة
        child: const ScanHistoryScreen(isFromBottomNav: true),
      ),

      BlocProvider(
        create: (context) =>
            ProfileCubit(repo: ProfileRepo(ApiServices(DioFactory.getDio())))
              ..getProfileInfo(),
        child: const ProfileScreen(isFromBottomNav: true),
      ),
      BlocProvider(
        create: (context) =>
            SettingCubit(repo: SettingRepo(ApiServices(DioFactory.getDio())))
              ..getUsernfo(),
        child: const SettingsScreen(isFromBottomNav: true),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0, // السماح بالرجوع فقط من الشاشة الرئيسية
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        setState(() {
          _currentIndex = 0;
        });
      },
      child: Scaffold(
        extendBody: true, // ضروري لجعل الشاشة تمتد خلف الـ BottomNavBar
        backgroundColor: const Color.fromRGBO(
          15,
          20,
          30,
          1,
        ), // لون الخلفية العام
        // استخدام IndexedStack للحفاظ على حالة الشاشات عند التنقل
        body: IndexedStack(index: _currentIndex, children: _screens),

        // 1. الزر العائم في المنتصف (الكاميرا)
        floatingActionButton: Container(
          height: 64.w,
          width: 64.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.blue.withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              // الانتقال إلى شاشة الكاميرا دون تغيير الـ Index الأساسي
              context.pushNamed(Routes.cameraScan);
            },
            backgroundColor: AppColor.blue,
            elevation: 0,
            shape: const CircleBorder(),
            child: Icon(
              Icons.camera_alt_rounded,
              color: Colors.white,
              size: 30.w,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // 2. الشريط السفلي المخصص
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromRGBO(23, 30, 41, 0.95),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.h, // مساحة الفراغ حول الزر العائم
          elevation: 10,
          child: SizedBox(
            height: 85.h, // تم زيادة الارتفاع لحل مشكلة التجاوز (Overflow)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // القسم الأيمن (Home - History)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home,
                        label: 'Home',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Icons.history_outlined,
                        activeIcon: Icons.history,
                        label: 'History',
                        index: 1,
                      ),
                    ],
                  ),
                ),

                // مساحة فارغة في المنتصف للزر العائم
                SizedBox(width: 48.w),

                // القسم الأيسر (Profile - Settings)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        icon: Icons.person_outline,
                        activeIcon: Icons.person,
                        label: 'Profile',
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: Icons.settings_outlined,
                        activeIcon: Icons.settings,
                        label: 'Settings',
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة لبناء أيقونات الـ Navigation Bar بشكل ديناميكي
  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 2.h, // تم تقليل المساحة الرأسية لحل مشكلة التجاوز
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 26.w,
              color: isSelected ? AppColor.blue : AppColor.grayText,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyle.font12semibold.copyWith(
                color: isSelected ? AppColor.blue : AppColor.grayText,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
