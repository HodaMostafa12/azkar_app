import 'package:azkar_app/view/Authentication/const_widgets/const_text_feild.dart';
import 'package:azkar_app/view/Authentication/sign_up/sign_up_screan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 56.h, left: 70.w, right: 70.w),
            child: Image.asset(isDark
                ? 'assets/images/logo_dark_1024.png'
                : 'assets/images/logo_light_1024 (2).png'),
          ),
          Container(
            width: 300.w,
            height: 438.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "تسجيل الدخول لحسابك",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "البريد الالكترونى",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: colors.primary,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ConstTextField(
                  hintText: "ادخل البريد الخاص بك",
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "كلمه المرور",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: colors.primary,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ConstTextField(
                  hintText: "ادخل كلمه المرور",
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "هل نسيت كلمة المرور؟",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Color(0xFF04519F),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 35.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          colors.primary, // اللون الأساسي من الـ theme
                      foregroundColor: colors.onPrimary, // لون النص
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // زوايا دائرية
                      ),
                    ),
                    onPressed: () {
                      // هنا تحطي أكشن الزر
                    },
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SignUpScrean()));
                    },
                    child: Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: colors.error,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: colors.error // خط تحت النص
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "ليس لديك حساب؟",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ])
              ],
            ),
          )
        ],
      )),
    );
  }
}
