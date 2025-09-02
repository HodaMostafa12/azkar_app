import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// A reusable checkbox widget with a larger size and customizable outline.
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color borderColor; // Added for outline color
  final Color overlayColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.checkColor,
    required this.borderColor, // Added parameter
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
        overlayColor: MaterialStateProperty.all(overlayColor),
        side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(
            color: borderColor, // Set outline color
            width: 2.0, // Set outline thickness
          ),
        ),
      ),
    );
  }
}