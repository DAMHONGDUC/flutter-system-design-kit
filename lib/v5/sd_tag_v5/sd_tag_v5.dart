import 'package:flutter/material.dart';
import '../index.dart';

class SdTagV5 extends StatelessWidget {
  final String label;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double borderRadiusValue;
  final TextStyle? textStyle;

  const SdTagV5({
    super.key,
    required this.label,
    this.color = SdColorsV5.black,
    this.padding = const EdgeInsets.symmetric(
      horizontal: SdSpacingV5.s12,
      vertical: SdSpacingV5.s6,
    ),
    this.borderRadiusValue = SdSpacingV5.s100,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: SdColorsV5.transparent,
        border: Border.all(color: color, width: SdSpacingV5.s1),
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      child: Text(
        label,
        style: textStyle ?? SdTextStyleV5.body10().wColor(color),
      ),
    );
  }
}
