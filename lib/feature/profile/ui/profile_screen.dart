import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/profile/widgets/info_card.dart';
import 'package:syrian_currency/feature/profile/widgets/security_and_account_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(title: "Profile", icon: Icons.settings),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 128.w,
                              height: 128.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  strokeAlign: BorderSide.strokeAlignInside,
                                  color: AppColor.blue.withOpacity(0.2),
                                  width: 4.w,
                                  style: BorderStyle.solid,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/profile_image.png",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 2,
                              child: CircleAvatar(
                                backgroundColor: AppColor.blue,
                                child: Icon(
                                  Icons.verified_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        3.verticalSpace,
                        Text("Majd Khalifa", style: AppTextStyle.font24bold),
                        9.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield_outlined, color: AppColor.blue),
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
                          "Member since Oct 2023",
                          style: AppTextStyle.font14regular,
                        ),
                        24.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: AppBottom(
                            text: "Edit Profile",
                            boxShadow: [],
                            icon: Icons.edit_outlined,
                          ),
                        ),
                        24.verticalSpace,
                        Row(
                          children: [
                            InfoCard(number: '128', text: 'SCANS'),
                            10.horizontalSpace,
                            InfoCard(number: "42", text: "BLOCKED"),
                            10.horizontalSpace,
                            InfoCard(number: "15", text: "SAFE DAYS"),
                          ],
                        ),
                        8.verticalSpace,
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SECURIT & ACCOUNT",
                                style: AppTextStyle.font12semibold.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.grayText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              16.verticalSpace,
                              SecurityAndAccountCard(
                                widget: SvgPicture.asset(
                                  "assets/svgs/shield.svg",
                                ),
                                text: 'Account Security',
                              ),
                              22.verticalSpace,
                              SecurityAndAccountCard(
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
                                backGroundColor: AppColor.red.withOpacity(0.1),
                                icon: Icons.logout,
                              ),
                            ],
                          ),
                        ),
                      ],
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
