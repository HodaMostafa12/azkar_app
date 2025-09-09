// lib/main.dart

import 'package:azkar_app/theme/app_theme.dart';
import 'package:azkar_app/theme/theme_provider.dart';
import 'package:azkar_app/view/Authentication/log_in/login_screan.dart';
import 'package:azkar_app/view/Authentication/view_model/auth_viewModel.dart';
import 'package:azkar_app/view/todo_screen/view_model/todo_view_model.dart';
import 'package:azkar_app/view/Pray_Time/prayer_time_view_model/prayer_time_view_model.dart';
import 'package:azkar_app/view/azkar/azkar_view_model/azkar_view_model.dart';
import 'package:azkar_app/view/electronic_sebha/electronic_sebha_viewModel/electronic_sebha_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'view/main_screen/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Supabase.initialize(
    url: 'https://wxbafynocquilkaywwpe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4YmFmeW5vY3F1aWxrYXl3d3BlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1Mjc0MzEsImV4cCI6MjA3MTEwMzQzMX0.Ic2v57k6iolvTaBa_hcBBm5Xz0qCKt_WlmW4Vq5Q3qg',
  );

  // initialize locale data
  await initializeDateFormatting('ar', null);

  // 1. Create an instance of AuthViewModel.
  final authViewModel = AuthViewModel();

  // 2. Call the init() method on it to load the current user.
  authViewModel.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            // 3. Provide the existing instance to the widget tree.
            ChangeNotifierProvider.value(value: authViewModel),
            ChangeNotifierProvider(create: (_) => SebhaViewModel()),
            ChangeNotifierProvider(create: (_) => AzkarViewModel()),
            ChangeNotifierProvider(create: (_) => PrayerTimeViewModel()),
            ChangeNotifierProvider(create: (_) => TodoViewModel()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final authViewModel = context.watch<AuthViewModel>();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Azkar App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: authViewModel.user != null
              ? const MainScreen()
              : const LoginScreen(),
        );
      },
    );
  }
}