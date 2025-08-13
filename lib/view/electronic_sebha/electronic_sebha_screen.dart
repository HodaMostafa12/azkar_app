import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'electronic_sebha_viewModel/electronic_sebha_viewModel.dart';

class SebhaView extends StatelessWidget {
  const SebhaView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SebhaViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E0D0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E0D0),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "السبحة الالكترونية",
          style: TextStyle(
            color: const Color(0xFFCB3526),
            fontWeight: FontWeight.bold,
            fontSize: 30.sp,
            fontFamily: 'Inter',
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: SizedBox(
            width: 250.w,
            child: const Divider(
              color: Color(0xFFCB3526),
              thickness: 1,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "العدات",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 250.w,
                height: 250.w, // Keep it square and responsive
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFECC5B8),
                  border: Border.all(color: const Color(0xFFE09991)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${viewModel.count}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36.sp,
                    color: const Color(0xFF152D45),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF155F5E),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                onPressed: viewModel.increment,
                child: Text(
                  "اضغط هنا للعد",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCB3526),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                onPressed: viewModel.reset,
                child: Text(
                  "إعادة التصفير",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
