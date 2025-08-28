// azkar_detail_screen.dart

import 'package:azkar_app/view/azkar/repository/azkar_model/azkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/appbar.dart';

class AzkarDetailScreen extends StatefulWidget {
  final AzkarModel azkarItem;

  const AzkarDetailScreen({
    Key? key,
    required this.azkarItem,
  }) : super(key: key);

  @override
  _AzkarDetailScreenState createState() => _AzkarDetailScreenState();
}

class _AzkarDetailScreenState extends State<AzkarDetailScreen> {
  late List<int> _currentCounts;

  @override
  void initState() {
    super.initState();
    // Initialize the counts for each zekr in the list
    _currentCounts = List<int>.filled(widget.azkarItem.array.length, 0);
    for (int i = 0; i < widget.azkarItem.array.length; i++) {
      _currentCounts[i] = widget.azkarItem.array[i].count ?? 0;
    }
  }

  void _incrementZekr(int index) {
    setState(() {
      if (_currentCounts[index] > 0) {
        _currentCounts[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.azkarItem.category ?? "الذكر",
          showBackButton: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: widget.azkarItem.array.length,
                itemBuilder: (context, index) {
                  final item = widget.azkarItem.array[index];
                  final colors = Theme.of(context).colorScheme;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF162F43),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.text ?? "",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: const Color(0xFFE7E0D0),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () => _incrementZekr(index),
                            child: Container(
                             // height: 100.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _currentCounts[index] == 0
                                    ? Colors.red.shade900
                                    : colors.error,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Center(
                                child: Text(
                                  _currentCounts[index].toString(),
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}