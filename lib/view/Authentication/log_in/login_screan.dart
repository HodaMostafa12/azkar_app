import 'package:azkar_app/view/Authentication/const_widgets/const_text_feild.dart';
import 'package:azkar_app/view/Authentication/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../main_screen/main_screen.dart';
import '../view_model/auth_viewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ---- Logo ----
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 70.w, right: 70.w),
                child: Image.asset('assets/images/logo_light_1024 (2).png',
                ),
              ),
              SizedBox(
                width: 300.w,
                height: 480.h,
                child: Form(
                  key: _formKey,
                  child: Consumer<AuthViewModel>(
                    builder: (context, authVM, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /// ---- Title ----
                          Text(
                            "تسجيل الدخول لحسابك",
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          /// ---- Email ----
                          Text(
                            "البريد الالكترونى",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ConstTextField(
                            controller: email,
                            hintText: "ادخل البريد الخاص بك",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "البريد الإلكتروني مطلوب";
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return "أدخل بريد إلكتروني صالح";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5.h),

                          /// ---- Password ----
                          Text(
                            "كلمه المرور",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ConstTextField(
                            controller: pass,
                            hintText: "ادخل كلمه المرور",
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "كلمة المرور مطلوبة";
                              }
                              if (value.length < 6) {
                                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5.h),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xFF04519F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 35.h),

                          /// ---- Login Button ----
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:const Color(0xFF2A6C69),
                                foregroundColor:const Color(0xFF2A6C69),
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: authVM.isLoading
                                  ? null
                                  : () async {
                                if (_formKey.currentState!.validate()) {
                                  await authVM.login(
                                    email.text.trim(),
                                    pass.text.trim(),
                                  );

    if (authVM.error != null) {
    String errorMessage = authVM.error!;

    if (authVM.error!.contains("Invalid login credentials")) {
    errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
    } else if (authVM.error!.contains("Email not confirmed")) {
    errorMessage = "يرجى تأكيد بريدك الإلكتروني قبل تسجيل الدخول";
    } else if (authVM.error!.contains("network")) {
    errorMessage = "تحقق من اتصالك بالإنترنت";
    }

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
    ),
    );

                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const MainScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: authVM.isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 5.h),

                          /// ---- Sign Up ----
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "إنشاء حساب جديد",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color:const Color(0xFFD91602),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: colors.error,
                                  ),
                                ),
                              ),
                              Text(
                                "  ليس لديك حساب؟",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
