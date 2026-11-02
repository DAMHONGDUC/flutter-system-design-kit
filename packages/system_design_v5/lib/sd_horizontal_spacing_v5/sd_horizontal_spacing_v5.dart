import 'package:flutter/material.dart';
import '../sd_spacing_v5/sd_spacing_v5.dart';

class SdVerticalSpacingV5 extends StatelessWidget {
  const SdVerticalSpacingV5({
    super.key,
    this.value,
    this.xRatio = 1,
    this.bgColor,
  });
  final double? value;
  final double xRatio;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    if (bgColor != null) {
      return Container(
        height: (value ?? SdSpacingV5.s12) * xRatio,
        color: bgColor,
      );
    }
    return SizedBox(height: (value ?? SdSpacingV5.s12) * xRatio);
  }
}
