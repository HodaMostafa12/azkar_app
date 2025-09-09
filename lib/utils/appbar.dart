import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 final String title;
 final bool showBackButton; // 👈 تحكم يدوي في زر الرجوع

 const CustomAppBar({
  super.key,
  required this.title,
  this.showBackButton = false, // 👈 افتراضي بدون زر رجوع
 });

 @override
 Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  final textTheme =Theme.of(context).textTheme;

  return AppBar(
   backgroundColor: colors.background,
   centerTitle: true,
   elevation: 0,
   automaticallyImplyLeading: false, // 👈 نوقف الافتراضي
   leading: showBackButton
       ? IconButton(
    icon: Icon(Icons.arrow_back_ios, color: colors.error),
    onPressed: () => Navigator.of(context).maybePop(),
   )
       : null, // 👈 لو false مش هيظهر
   title: Text(
    title,
    style: TextStyle(
     color: colors.error,
     fontWeight: FontWeight.bold,
     fontSize: 22.sp,
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
