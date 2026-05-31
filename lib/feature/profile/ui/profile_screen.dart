// ignore_for_file: use_build_context_synchronously, deprecated_member_use

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
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/profile/logic/profile_cubit.dart';
import 'package:syrian_currency/feature/profile/logic/profile_state.dart';
import 'package:syrian_currency/feature/profile/widgets/info_card.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';

class ProfileScreen extends StatelessWidget {
  final bool isFromBottomNav;
  const ProfileScreen({super.key, this.isFromBottomNav = false});

  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "Profile",
              icon: Icons.settings,
              suffixsIcon: isFromBottomNav ? const SizedBox() : null,
              onBackTap: () {
                context.pop();
              },
              onTap: () {
                context.pushNamed(Routes.settingScreen);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoading || state is ProfileInit) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ProfileFailure) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (state is ProfileSuccess) {
                          final user = state.user;
                          // 👈 1. تحديد هل المستخدم خبير لمعرفة كيفية عرض الواجهة
                          final bool isExpert =
                              user.role == 'expert' || user.role == 'admin';
                          final Color badgeColor = isExpert
                              ? Colors.purpleAccent
                              : AppColor.blue;
                          final String badgeText = isExpert
                              ? "SHIELD AI EXPERT"
                              : "SHIELD AI MEMBER";

                          return Column(
                            children: [
                              ProfileImageHolder(
                                imagePath:
                                    user.avatar ??
                                    "assets/images/profile_image.png",
                                icon: Icons.verified_outlined,
                              ),
                              3.verticalSpace,
                              Text(
                                user.fullName,
                                style: AppTextStyle.font24bold,
                              ),
                              9.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shield_outlined,
                                    color:
                                        badgeColor, // 👈 استخدام اللون الديناميكي
                                  ),
                                  Text(
                                    badgeText, // 👈 استخدام النص الديناميكي
                                    style: AppTextStyle.font14regular.copyWith(
                                      color: badgeColor,
                                      fontWeight: FontWeight.w600,
                                      height: 20 / 14,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                ],
                              ),
                              4.verticalSpace,
                              Text(
                                "Member since ${user.dateJoined.substring(0, 10)}",
                                style: AppTextStyle.font14regular,
                              ),
                              24.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 19.w),
                                child: AppBottom(
                                  text: "Edit Profile",
                                  boxShadow: const [],
                                  icon: Icons.edit_outlined,
                                  onPressed: () async {
                                    await context
                                        .pushNamed(Routes.editProfile)
                                        .then((_) {
                                          context
                                              .read<ProfileCubit>()
                                              .getProfileInfo();
                                        });
                                  },
                                ),
                              ),
                              24.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: InfoCard(
                                      number:
                                          '${user.totalScans ?? 0}', // ربط الإحصائيات إذا كانت موجودة بالموديل
                                      text: 'SCANS',
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: InfoCard(
                                      number: "${user.counterfeitScans ?? 0}",
                                      text: "BLOCKED",
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: InfoCard(
                                      number:
                                          (user.counterfeitScans == 0
                                                  ? number += 1
                                                  : 0)
                                              .toString(),
                                      text: "SAFE DAYS",
                                    ),
                                  ),
                                ],
                              ),
                              8.verticalSpace,
                              Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "SECURITY & ACCOUNT",
                                      style: AppTextStyle.font12semibold
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.grayText,
                                          ),
                                      textAlign: TextAlign.start,
                                    ),
                                    16.verticalSpace,

                                    // 👈 2. إظهار زر التقارير حصرياً للخبراء
                                    if (isExpert) ...[
                                      OptionsCard(
                                        widget: const Icon(
                                          Icons.fact_check_outlined,
                                          color: Colors.purpleAccent,
                                          size: 28,
                                        ),
                                        text: 'My Reports',
                                        onTap: () {
                                          context.pushNamed(Routes.myReports);
                                        },
                                      ),
                                      22.verticalSpace,
                                    ],

                                    OptionsCard(
                                      widget: SvgPicture.asset(
                                        "assets/svgs/shield.svg",
                                      ),
                                      text: 'Account Security',
                                    ),
                                    22.verticalSpace,
                                    OptionsCard(
                                      widget: SvgPicture.asset(
                                        "assets/svgs/shield_search.svg",
                                      ),
                                      text: 'Privacy Policy',
                                    ),
                                    24.verticalSpace,
                                    AppBottom(
                                      text: "Log Out",
                                      boxShadow: const [],
                                      color: AppColor.red,
                                      textcolor: AppColor.red,
                                      backGroundColor: AppColor.red.withOpacity(
                                        0.1,
                                      ),
                                      icon: Icons.logout,
                                      onPressed: () {
                                        // 👈 مرة واحدة فقط، وتحتوي على الكود الصحيح
                                        final pref = SharedPreferencesService();
                                        pref.clearTokens();
                                        context.pushNamedAndRemoveUntil(
                                          Routes.logIn,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
