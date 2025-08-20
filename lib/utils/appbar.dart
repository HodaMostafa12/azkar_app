import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 final String title;
 final bool automaticallyImplyLeading; // 👈 أضفنا الخاصية

 const CustomAppBar({
  super.key,
  required this.title,
  this.automaticallyImplyLeading = false, // 👈 افتراضي يظهر زر الرجوع
 });

 @override
 Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return AppBar(
   backgroundColor: colors.background,
   centerTitle: true,
   elevation: 0,
   automaticallyImplyLeading: automaticallyImplyLeading, // 👈 هنا التفعيل
   title: Text(
    title,
    style: TextStyle(
     color: colors.error,
     fontWeight: FontWeight.bold,
     fontSize: 30.sp,
     fontFamily: 'Inter',
    ),
   ),
   bottom: PreferredSize(
    preferredSize: Size.fromHeight(1.h),
    child: SizedBox(
     width: 250.w,
     child: Divider(
      color: colors.error,
      thickness: 1,
     ),
    ),
   ),
  );
 }

 @override
 Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.h);
}
