
import 'package:azkar_app/view/electronic_sebha/electronic_sebha_viewModel/electronic_sebha_viewModel.dart';
import 'package:azkar_app/view/home_screen/home_page.dart';
import 'package:azkar_app/view/login_screan.dart';
import 'package:azkar_app/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SebhaViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen()
      ),
    );
  }
}
