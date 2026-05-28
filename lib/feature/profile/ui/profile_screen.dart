// ignore_for_file: deprecated_member_use

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
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/profile/logic/profile_cubit.dart';
import 'package:syrian_currency/feature/profile/logic/profile_state.dart';
import 'package:syrian_currency/feature/profile/widgets/info_card.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "Profile",
              icon: Icons.settings,
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
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (state is ProfileSuccess) {
                          final user = state.user;
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
                                    color: AppColor.blue,
                                  ),
                                  Text(
                                    "SHIELD AI MEMBER",
                                    style: AppTextStyle.font14regular.copyWith(
                                      color: AppColor.blue,
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
                                  boxShadow: [],
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
                                    child: const InfoCard(
                                      number: '128',
                                      text: 'SCANS',
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: const InfoCard(
                                      number: "42",
                                      text: "BLOCKED",
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: const InfoCard(
                                      number: "15",
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
                                      boxShadow: [],
                                      color: AppColor.red,
                                      textcolor: AppColor.red,
                                      backGroundColor: AppColor.red.withOpacity(
                                        0.1,
                                      ),
                                      icon: Icons.logout,
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
