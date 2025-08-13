import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  final List<String> options = [
    "الاذكار",
    "مواقيت الصلاة",
    "المصحف",
    "المصحف",
    "القبلة",
    "المهام اليومية"
  ];
  final List<bool> _tasks = [false, false, false, false, false];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0D0),
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: const Color(0xFFE7E0D0),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: const Color(0xFF162F43),
            child: Text(
              "R",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
        ),
        title: SizedBox(
          height: 80.h,
          width: 140.w,
          child: SvgPicture.asset(
            "assets/images/fzkrAppBar.svg",
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              Text(
                "الورد اليومى",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: const Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10.h),

              // First container
              Container(
                padding: EdgeInsets.all(16.w),
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: const Color(0xFF152D45),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "سورة البقرة، آية 100\n"
                              "أَوَكُلَّمَا عَاهَدُوا عَهْدًا نَّبَذَهُ فَرِيقٌ مِّنْهُم...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: const Color(0xFFCB3526),
                          size: 20.sp,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                "المهام اليومية",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: const Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10.h),

              // Second container
              Container(
                height: 220.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: const Color(0xFF155F5E),
                ),
                child: Column(
                  children: [
                    _buildTaskItem("أذكار الصباح", 0),
                    _buildTaskItem("الورد اليومى", 1),
                    _buildTaskItem("أذكار المساء", 2),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: const Color(0xFFCB3526),
                          size: 20.sp,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                "الانشطة",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: const Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10.h),

              // GridView
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: options.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 16.w,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF152D45),
                    child: Center(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontFamily: "B Fantezy",
                          color: Colors.white,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Right-aligned checkbox + text
  Widget _buildTaskItem(String title, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        Checkbox(
          value: _tasks[index],
          onChanged: (val) {
            setState(() {
              _tasks[index] = val ?? false;
            });
          },
          checkColor: Colors.black,
          fillColor: MaterialStateProperty.all(Colors.white),
          activeColor: const Color(0xFFCB3526),
        ),
      ],
    );
  }
}
