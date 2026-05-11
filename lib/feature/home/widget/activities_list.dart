import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/home/widget/activity_card.dart';

class ActivitiesList extends StatefulWidget {
  const ActivitiesList({super.key});

  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  bool more = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Recent Activity", style: AppTextStyle.font18bold),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  more = !more;
                });
              },
              child: Text("View All", style: AppTextStyle.font12semibold),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          itemCount: more ? 10 : 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ActivityCard(icon: Icons.check_circle_outline_outlined);
          },
        ),
      ],
    );
  }
}
