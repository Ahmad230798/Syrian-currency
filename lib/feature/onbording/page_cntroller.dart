import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/feature/onbording/pages/on_boarding1.dart';
import 'package:syrian_currency/feature/onbording/pages/on_boarding2.dart';
import 'package:syrian_currency/feature/onbording/pages/on_boarding3.dart';

class PageCntroller extends StatefulWidget {
  const PageCntroller({super.key});

  @override
  State<PageCntroller> createState() => _PageCntrollerState();
}

class _PageCntrollerState extends State<PageCntroller> {
  final PageController _pageCntroller = PageController();
  int currentIndex = 0;
  @override
  void dispose() {
    _pageCntroller.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentIndex < 2) {
      _pageCntroller.animateToPage(
        currentIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // navigate to home page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _pageCntroller,
                  children: [OnBoarding1(), OnBoarding2(), OnBoarding3()],
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 6.h,
                    duration: Duration(microseconds: 300),
                    width: currentIndex == index ? 32 : 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: currentIndex == index
                          ? AppColor.blue
                          : AppColor.gray,
                    ),
                  );
                }),
              ),
              SizedBox(height: 15.h),
              AppBottom(text: 'Next Step'),
              SizedBox(height: 24),
              InkWell(
                onTap: () {
                  //
                },
                child: SizedBox(
                  width: 1.sw,
                  height: 30.h,
                  child: Text(
                    "Skip Intro",
                    style: AppTextStyle.font16medium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
