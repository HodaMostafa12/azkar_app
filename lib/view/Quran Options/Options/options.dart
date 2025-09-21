// option.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Quran/Repository/Quran-Model/quran-model.dart';
import '../../Quran/recitation.dart';
import '../Listen/listening.dart';

class Option extends StatelessWidget {
  final Surah surah;

  const Option({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top container with Surah name and image
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 260.h,
              width: 360.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Image on the left
                    Image.asset("assets/images/mos7af.png", height: 160.h,),
                    const Spacer(), // Pushes the next widget to the end
                    // Surah name on the right
                    Text(
                      surah.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // "تلاوه" button
          _buildOptionButton(
            context,
            text: "تلاوه",
            iconPath: "assets/icons/telawa.png",
            color: colors.secondary,
            onTap: () {  Navigator.push(
                context,
                MaterialPageRoute(
                builder: (_) => Telawa(surah: surah), // pass actual Surah
              ),);},
          ),
          // "استماع" button
          _buildOptionButton(
            context,
            text: "استماع",
            iconPath: "assets/icons/listen.png",
            color: colors.error,
            onTap: () { Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Listening(surah: surah), // pass actual Surah
              ),);},
          ),
          // "تفسير" button
          _buildOptionButton(
            context,
            text: "تفسير",
            iconPath: "assets/icons/tfseer.png",
            color: colors.secondary,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // A helper method to build the option buttons
  Widget _buildOptionButton(
      BuildContext context, {
        required String text,
        required String iconPath,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 90.h,
          width: 360.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text on the left
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                // Icon on the right
                Image.asset(iconPath),
              ],
            ),
          ),
        ),
      ),
    );
  }
}