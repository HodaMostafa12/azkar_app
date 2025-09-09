// azkar_screen.dart

import 'dart:ui';
import 'package:azkar_app/utils/appbar.dart';
import 'package:azkar_app/view/azkar/repository/azkar_model/azkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'azkar_details_screen.dart';
import 'azkar_view_model/azkar_view_model.dart';
 // Import the new screen

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AzkarViewModel>(context, listen: false).getAzkar());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AzkarViewModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "الاذكار", showBackButton: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Center(child: Padding(
              padding:  EdgeInsets.only(right: 16.w, left: 16.w),
              child: Image.asset("assets/images/azkarImage.png"),
            )),
            SizedBox(height: 20.h),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (vm.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (vm.errorMessage != null) {
                    return Center(child: Text("Error: ${vm.errorMessage}"));
                  }
                  if (vm.azkar.isEmpty) {
                    return const Center(child: Text("لا يوجد بيانات"));
                  }
                  return ListView.builder(
                    itemCount: vm.azkar.length,
                    itemBuilder: (context, index) {
                      final item = vm.azkar[index];
                      final arrayLength = item.array.length;
                      return Center(
                        child: _buildAzkarTile(
                          item: item, // 👈 Passing the whole object
                          isUserItem: item.userId != null,
                          onDelete: () {
                            if (item.id != null) {
                              vm.deleteAzkar(item.id!);
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:Color(0xFFCB3526),
          child: const Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            _showAddAzkarDialog(context, vm);
          },
        ),
      ),
    );
  }

  void _showAddAzkarDialog(BuildContext context, AzkarViewModel vm) {
    _titleController.clear();
    _countController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFF162F43),
          title: const Text(
            "إضافة ذكر",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                textAlign: TextAlign.end,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                  hintText: "الذكر",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                  hintText: "العدات",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                final title = _titleController.text.trim();
                final count = int.tryParse(_countController.text.trim()) ?? 0;

                if (title.isNotEmpty) {
                  vm.addAzkar(title, count);
                  Navigator.pop(context);
                }
              },
              child: const Text("حفظ"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAzkarTile({
    required AzkarModel item, // 👈 Accept the full item
    required bool isUserItem,
    required VoidCallback onDelete,
  }) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AzkarDetailScreen(azkarItem: item),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: const Color(0xFF102231),
              width: 2,
            ),
            color: colors.surface,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
                width: 50.w,
                child: Image.asset("assets/icons/elmsbha.png"),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.category ?? "بدون تصنيف",
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color:const Color(0xFFE7E0D0),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "عدد الأذكار: ${item.array.length}",
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color:const Color(0xFFE7E0D0).withOpacity(0.7),
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUserItem)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}