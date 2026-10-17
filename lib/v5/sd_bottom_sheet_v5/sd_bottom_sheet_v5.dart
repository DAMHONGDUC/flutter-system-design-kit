import 'package:flutter/material.dart';
import '../index.dart';

class SdBottomSheetV5 extends StatelessWidget {
  const SdBottomSheetV5({
    super.key,
    required this.child,
    this.title,
    this.bgColor,
    this.textColor,
    this.borderRadius,
  });
  final Widget child;
  final String? title;
  final Color? bgColor;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SdBottomSheetTopBarV5(title: title, textColor: textColor),
          if (title != null) SdVerticalSpacingV5(),
          child,
          SdVerticalSpacingV5(),
        ],
      ),
    );
  }
}
