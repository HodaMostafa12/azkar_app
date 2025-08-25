import 'package:azkar_app/view/Authentication/const_widgets/const_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../main_screen/main_screen.dart';
import '../view_model/auth_viewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
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
              /// Logo
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 70.w, right: 70.w),
                child: Image.asset(isDark
                    ? 'assets/images/logo_dark_1024.png'
                    : 'assets/images/logo_light_1024 (2).png'),
              ),

              SizedBox(
                width: 300.w,
                height: 500.h,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// Title
                      Text(
                        "انشاء حساب جديد",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// Username
                      Text(
                        "اسم المستخدم",
                        style: TextStyle(fontSize: 18.sp, color: colors.primary),
                      ),
                      SizedBox(height: 10.h),
                      ConstTextField(
                        controller: username,
                        hintText: "ادخل اسم المستخدم",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "اسم المستخدم مطلوب";
                          }
                          if (value.length < 3) {
                            return "اسم المستخدم يجب أن يكون 3 أحرف على الأقل";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.h),

                      /// Email
                      Text(
                        "البريد الالكترونى",
                        style: TextStyle(fontSize: 18.sp, color: colors.primary),
                      ),
                      SizedBox(height: 10.h),
                      ConstTextField(
                        controller: email,
                        hintText: "ادخل البريد الخاص بك",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "البريد الإلكتروني مطلوب";
                          }
                          // Regex للتحقق من صيغة الإيميل
                          final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return "أدخل بريد إلكتروني صالح (مثال: name@example.com)";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.h),

                      /// Password
                      Text(
                        "كلمه المرور",
                        style: TextStyle(fontSize: 18.sp, color: colors.primary),
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
                      SizedBox(height: 35.h),

                      /// SignUp Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: colors.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final authVM = context.read<AuthViewModel>();
                              await authVM.signUp(
                                email.text.trim(),
                                pass.text.trim(),
                                username.text.trim(),
                              );


                              if (authVM.user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const MainScreen()),
                                );
                              } else {
                                String errorMessage = "فشل إنشاء الحساب";

                                if (authVM.error != null) {
                                  if (authVM.error!.contains("already registered") ||
                                      authVM.error!.contains("already exists")) {
                                    errorMessage = "هذا البريد مستخدم من قبل، من فضلك جرب بريد آخر.";
                                  } else {
                                    errorMessage = authVM.error!;
                                  }
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },

                          child: Text(
                            "انشاء حساب",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),

                      /// Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: colors.error,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: colors.error,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            " لديك حساب بالفعل؟",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
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
