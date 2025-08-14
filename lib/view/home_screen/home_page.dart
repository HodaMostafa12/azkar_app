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
    final colors =Theme.of(context).colorScheme;
    final textTheme =Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor:colors.background,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: colors.primary,
            child: Text(
              "R",
              style: TextStyle(color: colors.background, fontSize: 18.sp),
            ),
          ),
        ),
        title: SizedBox(
          height: 80.h,
          width: 140.w,
          child: SvgPicture.asset(
            "assets/icons/fzkrAppBar.svg",
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
                  color: colors.error,
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
                  color: colors.primary,
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
                            color: colors.background,
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
                          color: colors.error,
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
                  color: colors.error,
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
                  color: colors.secondary,
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
                  color: colors.error,
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
                    color: colors.primary,
                    child: Center(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontFamily: "B Fantezy",
                          color: colors.background,
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
