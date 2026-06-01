// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/settings_screen/logic/setting_cubit.dart';
import 'package:syrian_currency/feature/settings_screen/logic/setting_state.dart';
import 'package:syrian_currency/feature/settings_screen/widgets/settings_options.dart';

class SettingsScreen extends StatelessWidget {
  final bool isFromBottomNav;
  const SettingsScreen({super.key, this.isFromBottomNav = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MyAppBar(
                title: "Settings",
                suffixsIcon: isFromBottomNav ? const SizedBox() : null,
                onBackTap: () {
                  context.pop();
                },
              ),
              Expanded(
                child: BlocBuilder<SettingCubit, SettingState>(
                  builder: (context, state) {
                    if (state is SettingLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SettingFailureState) {
                      return Center(
                        child: Text(
                          "Something Went Wrong",
                          style: AppTextStyle.font14regular.copyWith(
                            color: AppColor.red,
                          ),
                        ),
                      );
                    }
                    if (state is SettingSuccessState) {
                      final user = state.user;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            38.verticalSpace,
                            ProfileImageHolder(
                              // 👈 الحل هنا: استخدام صورة افتراضية بدلاً من علامة !
                              imagePath:
                                  user.avatar ??
                                  "assets/images/profile_image.png",
                              icon: Icons.verified_outlined,
                            ),
                            16.verticalSpace,
                            Text(
                              user.fullName,
                              style: AppTextStyle.font30extraBold,
                            ),
                            Text(
                              // 👈 الحل هنا: منع طباعة كلمة "null"
                              user.tierLevel != null
                                  ? "Tier ${user.tierLevel}"
                                  : "Standard Member",
                              style: AppTextStyle.font16medium.copyWith(
                                color: AppColor.lightgray,
                                height: 19.6 / 16,
                                letterSpacing: 0,
                              ),
                            ),
                            32.verticalSpace,
                            const SettingsOptions(),
                            32.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: AppBottom(
                                onPressed: () {
                                  final pref = SharedPreferencesService();
                                  pref.clearTokens();
                                  context.pushNamedAndRemoveUntil(Routes.logIn);
                                },
                                text: "Log Out",
                                boxShadow: const [],
                                textcolor: AppColor.lightRed,
                                color: AppColor.lightRed,
                                backGroundColor: AppColor.lightRed.withOpacity(
                                  0.09,
                                ),
                                icon: Icons.logout,
                              ),
                            ),
                            50.verticalSpace,
                          ],
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
      ),
    );
  }
}
