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
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: "مواقيت الصلاة"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                SizedBox(width: 8.w),
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
          SizedBox(
            width: 300.w,
            child: Divider(
              color: Colors.black,
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
                      color: colors.secondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "6 يوليو 2025",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 300.w,
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPrayerTile(
                iconWidget: SvgPicture.asset("assets/icons/Sunrise.svg"),
                title: "الفجر",
                subtitle: "12:56",
              ),
              CustomCheckbox(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                activeColor: colors.background,
                checkColor: colors.secondary,
                borderColor: colors.secondary,
                overlayColor: colors.secondary,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPrayerTile(
                iconWidget: SvgPicture.asset("assets/icons/Cloudy.svg"),
                title: "الظهر",
                subtitle: "12:56",
              ),
              CustomCheckbox(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                activeColor: colors.background,
                checkColor: colors.secondary,
                borderColor: colors.secondary,
                overlayColor: colors.secondary,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPrayerTile(
                iconWidget: SvgPicture.asset("assets/icons/Sun set.svg"),
                title: "العصر",
                subtitle: "12:56",
              ),
              CustomCheckbox(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                activeColor: colors.background,
                checkColor: colors.secondary,
                borderColor: colors.secondary,
                overlayColor: colors.secondary,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPrayerTile(
                iconWidget: SvgPicture.asset("assets/icons/Sun set.svg"),
                title: "المغرب",
                subtitle: "12:56",
              ),
              CustomCheckbox(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                activeColor: colors.background,
                checkColor: colors.secondary,
                borderColor: colors.secondary,
                overlayColor: colors.secondary,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPrayerTile(
                iconWidget: SvgPicture.asset("assets/icons/Moon 2.svg"),
                title: "العشاء",
                subtitle: "12:56",
              ),
              CustomCheckbox(
                value: _isChecked,
                onChanged: (newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                activeColor: colors.background,
                checkColor: colors.secondary,
                borderColor: colors.secondary,
                overlayColor: colors.secondary,
              ),
            ],
          ),
          SizedBox(height: 30.h),
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
            // The title and icon are on the right (for RTL)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: colors.background,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: colors.background,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(colors.background, BlendMode.srcIn),
                  child: iconWidget,
                ),
                // Apply a color filter to the SVG to make it visible

              ],
            ),
          ],
        ),
      ),
    );
  }
}
