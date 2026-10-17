import 'package:flutter/material.dart';
import '../sd_colors_v5/sd_colors_v5.dart';

class SdDividerV5 extends StatelessWidget {
  const SdDividerV5({super.key, this.color, this.thickness});

  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? SdColorsV5.grey100,
      thickness: thickness ?? 1,
      height: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}
