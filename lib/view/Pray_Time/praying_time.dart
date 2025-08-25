import 'package:azkar_app/view/Pray_Time/utils/costum_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/appbar.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  // Corrected state class name
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  List<bool> _isCheckedList = List.filled(5, false);


  @override
  Widget build(BuildContext context) {
    final colors = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: const CustomAppBar(title: "مواقيت الصلاة"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: colors.error,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  color: colors.error,
                ),
                // SizedBox(width: 8.w),
                const Spacer(),
                Text(
                  "الاحد",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: colors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: colors.error,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child:  Divider(
              color: colors.primary,
              thickness: 1,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 75.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "11 محرم 1774",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "6 يوليو 2025",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child:  Divider(
              color:colors.primary,
              thickness: 1,
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                List<String> slah = [
                  "الفجر",
                  "الظهر",
                  "العصر",
                  "المغرب",
                  "العشاء"
                ];
                List<String> slahAssets = [
                  "assets/icons/sunrise.png",
                  "assets/icons/sun.png",
                  "assets/icons/sunCloud.png",
                  "assets/icons/sunset.png",
                  "assets/icons/moon22.png"
                ];

                return Column(
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildPrayerTile(
                          iconWidget: Image.asset(slahAssets[index]),
                          title: slah[index],
                          subtitle: "12:56",
                        ),
                        CustomCheckbox(
                          value: _isCheckedList[index], // كل واحدة لها index
                          onChanged: (newValue) {
                            setState(() {
                              _isCheckedList[index] = newValue!;
                            });
                          },
                          activeColor: colors.background,
                          checkColor: colors.secondary,
                          borderColor: colors.secondary,
                          overlayColor: colors.secondary,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPrayerTile({
    required String title,
    required String subtitle,
    required Widget iconWidget,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 80.h,
        width: 300.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: colors.secondary,
            width: 2,
          ),
          color: colors.secondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: iconWidget,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: colors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: colors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}