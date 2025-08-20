import 'package:azkar_app/theme/app_theme.dart';
import 'package:azkar_app/view/Authentication/log_in/login_screan.dart';
import 'package:azkar_app/view/Authentication/view_model/auth_viewModel.dart';
import 'package:azkar_app/view/electronic_sebha/electronic_sebha_viewModel/electronic_sebha_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'view/main_screen/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ initialize Supabase
  await Supabase.initialize(
    url: 'https://wxbafynocquilkaywwpe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4YmFmeW5vY3F1aWxrYXl3d3BlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1Mjc0MzEsImV4cCI6MjA3MTEwMzQzMX0.Ic2v57k6iolvTaBa_hcBBm5Xz0qCKt_WlmW4Vq5Q3qg',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SebhaViewModel()),
            ChangeNotifierProvider(create: (_) => AuthViewModel()), // ✅ add AuthViewModel
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Azkar App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,

            // ✅ If user already logged in → go to MainScreen, else LoginScreen
            home: Supabase.instance.client.auth.currentUser != null
                ? const MainScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }
}
