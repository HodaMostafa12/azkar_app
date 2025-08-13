import 'package:azkar_app/view/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../electronic_sebha/electronic_sebha_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Default to Home

  final List<Widget> _screens = [
    const Center(child: Text("الإعدادات")), // Settings placeholder
    const Center(child: Text("المفضلة")), // Favorites placeholder
    const HomePage(), // Your home screen body only
    const SebhaView(), // Sebha screen
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors =Theme.of(context).colorScheme;
    final textTheme =Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: colors.background,
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Padding(
          padding:  EdgeInsets.only(top: 4.h),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onNavTap,
            selectedItemColor: colors.error,
            unselectedItemColor: Colors.grey,
            backgroundColor: colors.primary,
            items: [
              _buildNavItem("assets/icons/settings.svg", "الإعدادات", 0),
              _buildNavItem("assets/icons/fav.svg", "المفضلة", 1),
              _buildNavItem("assets/icons/home.svg", "الرئيسية", 2),
              _buildNavItem("assets/icons/seb7a.svg", "السبحه الالكترونية", 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          _selectedIndex == index ? const Color(0xFFCB3526) : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
