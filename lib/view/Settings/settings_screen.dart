import 'package:azkar_app/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _languages = ['English', 'العربية', 'Français'];

  String _selectedLanguage = 'English';

  bool _isNightModeEnabled = false;
  bool _isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background, // A dark background color.
      appBar: CustomAppBar(title: "الاعدادات"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 16.h),
            Text(
              "hodamostafa@gmail.com",
              style: TextStyle(
                  fontFamily: "Inter",
                  color: colors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "العامة",
              style: TextStyle(
                fontFamily: "Inter",
                color: colors.error,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 16.h),
            _buildSettingsTile(
              title: "اللغة",
              iconWidget: SvgPicture.asset(
                "assets/icons/Global.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                underline: const SizedBox(),
                dropdownColor: colors.primary,
                icon: Icon(Icons.keyboard_arrow_down, color: colors.primary),
                items: _languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(
                      language,
                      style: TextStyle(color: colors.primary),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLanguage = newValue;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 16.h),
            _buildSettingsTile(
              title: "الوضع الليلي",
              iconWidget: SvgPicture.asset(
                "assets/icons/Moon.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
              trailing: Switch(
                value: _isNightModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNightModeEnabled = value;
                  });
                },
                trackOutlineColor: WidgetStateProperty.all(colors.primary),                activeColor: colors.secondary,
                inactiveTrackColor: colors.primary,
                inactiveThumbColor: colors.secondary,
              ),
            ),
            SizedBox(height: 16.h),
            _buildSettingsTile(
              title: "الأشعارات",
              iconWidget: SvgPicture.asset(
                "assets/icons/Notification.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
              trailing: Switch(
                value: _isNotificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationsEnabled = value;
                  });
                },
                trackOutlineColor: WidgetStateProperty.all(colors.primary),

                activeColor: colors.secondary,
                inactiveTrackColor: colors.primary,
                inactiveThumbColor: colors.secondary,
              ),
            ),
            SizedBox(height: 16.h),
            _buildSettingsTile(
              title: "تسجيل خروج",
              // `iconWidget` now accepts SvgPicture.
              iconWidget: SvgPicture.asset(
                "assets/icons/signout.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
              isButton: true,
              onTap: () {
              },
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    "تواصلوا معنا",
                    style: TextStyle(
                      fontFamily: "Inter",
                      color: colors.error,
                      fontSize: 30,
                    ),
                  ),
                  icon: Icon(Icons.person_search_rounded, color: colors.secondary, size: 30),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset("assets/icons/linkedin.svg", height: 100),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required Widget iconWidget,
    Widget? trailing,
    bool isButton = false,
    VoidCallback? onTap,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: colors.primary,
          width: 2,
        ),
        color: colors.background,
      ),
      child: InkWell(
        onTap: isButton ? onTap : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (trailing != null) trailing,
            const Spacer(),
            // The title and icon.
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: colors.primary,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 16.w),
                iconWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
