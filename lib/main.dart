import 'package:azkar_app/theme/app_theme.dart';
import 'package:azkar_app/view/electronic_sebha/electronic_sebha_viewModel/electronic_sebha_viewModel.dart';
import 'package:azkar_app/view/Authentication/log_in/login_screan.dart';
import 'package:azkar_app/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
 // Or HomePage if that's your start screen

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base design resolution
      minTextAdapt: true, // ✅ This must be here before you use .w/.h/.sp
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (_) => SebhaViewModel(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: child,
          ),
        );
      },
      child: LoginScreen(), // or HomePage
    );
  }
}
