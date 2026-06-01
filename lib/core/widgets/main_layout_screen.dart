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
import 'package:syrian_currency/core/widgets/main_layout_cubit.dart';

import 'package:syrian_currency/feature/home/logic/home_cubit.dart';
import 'package:syrian_currency/feature/home/repo/home_repo.dart';
import 'package:syrian_currency/feature/home/ui/home_screeen.dart';

import 'package:syrian_currency/feature/scan_history/logic/scan_history_cubit.dart';
import 'package:syrian_currency/feature/scan_history/repo/scan_history_repo.dart';
import 'package:syrian_currency/feature/scan_history/ui/scan_history_screen.dart';

import 'package:syrian_currency/feature/expert_feed/logic/expert_feed_cubit.dart';
import 'package:syrian_currency/feature/expert_feed/repo/expert_feed_repo.dart';
import 'package:syrian_currency/feature/expert_feed/ui/expert_feed_screen.dart';

import 'package:syrian_currency/feature/profile/logic/profile_cubit.dart';
import 'package:syrian_currency/feature/profile/repo/profile_repo.dart';
import 'package:syrian_currency/feature/profile/ui/profile_screen.dart';

import 'package:syrian_currency/feature/settings_screen/logic/setting_cubit.dart';
import 'package:syrian_currency/feature/settings_screen/repo/setting_repo.dart';
import 'package:syrian_currency/feature/settings_screen/ui/settings_screen.dart';
import 'package:syrian_currency/core/widgets/guest_restricted_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  List<Widget> _screens = [];
  bool _isLoading = true;
  String _userRole = 'user';

  @override
  void initState() {
    super.initState();
    _loadUserRoleAndScreens();
  }

  Future<void> _loadUserRoleAndScreens() async {
    final SharedPreferencesService prefService = SharedPreferencesService();
    _userRole = await prefService.getUserRole();

    // الشرط الذكي للزائر
    if (_userRole == 'guest') {
      _screens = [
        const HomeScreeen(), // الزائر يرى الشاشة الرئيسية ويقدر يصور عادي
        const GuestRestrictedScreen(
          title: "Scan History",
          icon: Icons.history_outlined,
        ),
        const GuestRestrictedScreen(
          title: "Profile",
          icon: Icons.person_outline,
        ),
        const GuestRestrictedScreen(
          title: "Settings",
          icon: Icons.settings_outlined,
        ),
      ];
    } else {
      // شاشات المستخدم/الخبير العادية
      _screens = [
        const HomeScreeen(),
        (_userRole == 'expert' || _userRole == 'admin')
            ? BlocProvider(
                create: (context) => ExpertFeedCubit(
                  ExpertFeedRepo(ApiServices(DioFactory.getDio())),
                )..fetchFeed(),
                child: const ExpertFeedScreen(isFromBottomNav: true),
              )
            : BlocProvider(
                create: (context) => ScanHistoryCubit(
                  ScanHistoryRepo(ApiServices(DioFactory.getDio())),
                )..fetchHistory(),
                child: const ScanHistoryScreen(isFromBottomNav: true),
              ),
        BlocProvider(
          create: (context) =>
              ProfileCubit(repo: ProfileRepo(ApiServices(DioFactory.getDio())))
                ..getProfileInfo(),
          child: const ProfileScreen(isFromBottomNav: true),
        ),
        const SettingsScreen(isFromBottomNav: true),
      ];
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color.fromRGBO(15, 20, 30, 1),
        body: Center(child: CircularProgressIndicator(color: AppColor.blue)),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainLayoutCubit()),

        // 👈 التعديل هنا: جلب البيانات فقط إذا لم يكن زواراً
        BlocProvider(
          create: (context) {
            final cubit = HomeCubit(
              HomeRepo(
                ApiServices(DioFactory.getDio()),
                SharedPreferencesService(),
              ),
            );
            if (_userRole != 'guest') cubit.getScanHistory();
            return cubit;
          },
        ),

        // توفير كيوبيت الخبير أو المستخدم العادي بناءً على الصلاحية
        if (_userRole == 'expert' || _userRole == 'admin')
          BlocProvider(
            create: (context) => ExpertFeedCubit(
              ExpertFeedRepo(ApiServices(DioFactory.getDio())),
            )..fetchFeed(),
          )
        else if (_userRole ==
            'user') // 👈 التعديل هنا: التأكد أنه user وليس guest
          BlocProvider(
            create: (context) => ScanHistoryCubit(
              ScanHistoryRepo(ApiServices(DioFactory.getDio())),
            )..fetchHistory(),
          ),

        // 👈 التعديل هنا: منع استدعاء البروفايل للزوار
        BlocProvider(
          create: (context) {
            final cubit = ProfileCubit(
              repo: ProfileRepo(ApiServices(DioFactory.getDio())),
            );
            if (_userRole != 'guest') cubit.getProfileInfo();
            return cubit;
          },
        ),

        // 👈 التعديل هنا: منع استدعاء الإعدادات للزوار
        BlocProvider(
          create: (context) {
            final cubit = SettingCubit(
              repo: SettingRepo(ApiServices(DioFactory.getDio())),
            );
            if (_userRole != 'guest') cubit.getUsernfo();
            return cubit;
          },
        ),
      ],
      child: BlocBuilder<MainLayoutCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<MainLayoutCubit>();

          return PopScope(
            canPop: currentIndex == 0,
            onPopInvoked: (didPop) {
              if (didPop) return;
              cubit.changeTab(0);
            },
            child: Scaffold(
              extendBody: true,
              backgroundColor: const Color.fromRGBO(15, 20, 30, 1),
              body: IndexedStack(index: currentIndex, children: _screens),
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
                  onPressed: () => context.pushNamed(Routes.cameraScan),
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                color: const Color.fromRGBO(23, 30, 41, 0.95),
                shape: const CircularNotchedRectangle(),
                notchMargin: 8.h,
                elevation: 10,
                child: SizedBox(
                  height: 85.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(
                              context,
                              Icons.home_outlined,
                              Icons.home,
                              'Home',
                              0,
                              currentIndex,
                              cubit,
                            ),
                            _buildNavItem(
                              context,
                              (_userRole == 'expert' || _userRole == 'admin')
                                  ? Icons.dynamic_feed_outlined
                                  : Icons.history_outlined,
                              (_userRole == 'expert' || _userRole == 'admin')
                                  ? Icons.dynamic_feed
                                  : Icons.history,
                              (_userRole == 'expert' || _userRole == 'admin')
                                  ? 'Audit Feed'
                                  : 'History',
                              1,
                              currentIndex,
                              cubit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 48.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(
                              context,
                              Icons.person_outline,
                              Icons.person,
                              'Profile',
                              2,
                              currentIndex,
                              cubit,
                            ),
                            _buildNavItem(
                              context,
                              Icons.settings_outlined,
                              Icons.settings,
                              'Settings',
                              3,
                              currentIndex,
                              cubit,
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
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
    int currentIndex,
    MainLayoutCubit cubit,
  ) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () {
        cubit.changeTab(index);

        // 👈 التعديل هنا: منع جلب البيانات إذا كان المستخدم زائراً
        if (_userRole != 'guest') {
          if (index == 0) {
            context.read<HomeCubit>().getScanHistory();
          } else if (index == 1) {
            if (_userRole == 'expert' || _userRole == 'admin') {
              context.read<ExpertFeedCubit>().fetchFeed();
            } else {
              context.read<ScanHistoryCubit>().fetchHistory();
            }
          } else if (index == 2) {
            context.read<ProfileCubit>().getProfileInfo();
          }
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
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
