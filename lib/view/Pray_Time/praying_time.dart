import 'package:adhan/adhan.dart';
import 'package:azkar_app/view/Pray_Time/prayer_time_view_model/prayer_time_view_model.dart';
import 'package:azkar_app/view/Pray_Time/utils/costum_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/appbar.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  List<bool> _isCheckedList = [];
  String _todayKey = "";

  @override
  void initState() {
    super.initState();
    _todayKey = DateFormat("yyyy-MM-dd").format(DateTime.now()); // ✅ مفتاح اليوم
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = Provider.of<PrayerTimeViewModel>(context, listen: false);
      await vm.loadPrayerTimes(30.0444, 31.2357);

      await _loadCheckboxState(vm.prayerTimes.length);
    });
  }

  /// ✅ تحميل حالة الـ Checkboxes
  Future<void> _loadCheckboxState(int length) async {
    final prefs = await SharedPreferences.getInstance();

    // تحقق لو التاريخ تغيّر → Reset
    final lastDate = prefs.getString("lastDate");
    if (lastDate != _todayKey) {
      _isCheckedList = List.filled(length, false);
      await prefs.setString("lastDate", _todayKey);
      await prefs.setStringList("checkboxes", _isCheckedList.map((e) => e.toString()).toList());
    } else {
      // لو نفس اليوم → استرجع الحالة
      final savedChecks = prefs.getStringList("checkboxes");
      if (savedChecks != null && savedChecks.length == length) {
        _isCheckedList = savedChecks.map((e) => e == "true").toList();
      } else {
        _isCheckedList = List.filled(length, false);
      }
    }

    setState(() {});
  }

  /// ✅ حفظ حالة الـ Checkboxes
  Future<void> _saveCheckboxState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("checkboxes", _isCheckedList.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PrayerTimeViewModel>(context);
    final colors = Theme.of(context).colorScheme;

    String hijriDate = "";
    String gregorianDate = "";
    String dayName = "";

    if (viewModel.date != null) {
      final date = viewModel.date!;
      final hijri = HijriCalendar.fromDate(date);

      hijriDate = "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ";
      gregorianDate = DateFormat("dd MMMM yyyy", "ar").format(date);
      dayName = DateFormat("EEEE", "ar").format(date);
    }

    return Scaffold(
      backgroundColor: colors.background,
      appBar: const CustomAppBar(title: "مواقيت الصلاة", showBackButton: true),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.h),

          // ✅ التاريخ فوق القائمة
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 8.w),
                    Text(
                      dayName,
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
                Divider(color: colors.primary, thickness: 1),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hijriDate,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          gregorianDate,
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

                Divider(color: colors.primary, thickness: 1),
              ],
            ),
          ),

          // ✅ قائمة مواقيت الصلاة
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.prayerTimes.length,
              itemBuilder: (context, index) {
                final prayer = viewModel.prayerTimes[index];
                final formattedTime = DateFormat("hh:mm a").format(prayer.time);
                List<String> slahAssets = [
                  "assets/icons/fajr.png",
                  "assets/icons/sunrise.png",
                  "assets/icons/sun.png",
                  "assets/icons/sunCloud.png",
                  "assets/icons/sunset.png",
                  "assets/icons/moon22.png" ];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPrayerTile(
                      title: prayer.name,
                      subtitle: formattedTime,
                      iconWidget:Image.asset(slahAssets[index]),
                    ),
                    CustomCheckbox(
                      value: index < _isCheckedList.length ? _isCheckedList[index] : false,
                      onChanged: (newValue) {
                        setState(() {
                          _isCheckedList[index] = newValue!;
                        });
                        _saveCheckboxState(); // ✅ احفظ التغيير
                      },
                      activeColor: Colors.white, // ✅ خلفية بيضاء عند التفعيل
                      checkColor: colors.secondary, // ✅ لون علامة الصح
                      borderColor: colors.secondary,
                      overlayColor: colors.secondary,
                    ),
                  ],
                );
              },
            ),
          ),
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
    return Container(
      margin: const EdgeInsets.all(8),
      height: 80.h,
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: colors.secondary, width: 2),
        color: colors.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconWidget,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title,
                  style: TextStyle(
                      color: colors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: TextStyle(
                      color: colors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
