import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/feature/scan_history/widgets/scan_card.dart';

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  int _selectedIndex = 0;
  final List<String> _options = ["All", "Genuine", "Counterfeit"];

  final List<Widget> _views = [
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ScanCard();
      },
    ),
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ScanCard(color: AppColor.green);
      },
    ),
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return ScanCard(result: "Counterfeit", color: AppColor.red);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45.h, // الطول المناسب كما في الصورة
          decoration: BoxDecoration(
            color: AppColor.mainContainerBackGround,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // حساب العرض المتاح لكل عنصر بدقة
              double itemWidth = constraints.maxWidth / _options.length;

              return Stack(
                children: [
                  // 1. الزر الأزرق المنزلق (AnimatedPositioned هو الأفضل هنا)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    // نضرب ترتيب العنصر في عرضه ليعرف مكانه بالضبط
                    left: _selectedIndex * itemWidth,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: itemWidth,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),

                  // 2. الصف الذي يحتوي على النصوص (هذا العنصر هو الذي يعطي الـ Stack حجمه)
                  Row(
                    children: List.generate(_options.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedIndex = index),
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: Text(
                              _options[index],
                              style: TextStyle(
                                // تغيير اللون بناءً على الاختيار
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
        32.verticalSpace,
        _views[_selectedIndex],
      ],
    );
  }
}
