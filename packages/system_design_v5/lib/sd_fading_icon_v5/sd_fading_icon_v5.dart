import 'package:flutter/material.dart';
import '../sd_spacing_v5/sd_spacing_v5.dart';

class SdFadingIconV5 extends StatelessWidget {
  final IconData iconData;
  final Color? bgColor;
  final Color? iconColor;
  final double? iconSize;
  final void Function()? onTap;

  const SdFadingIconV5({
    super.key,
    required this.iconData,
    this.bgColor,
    this.iconColor,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SdSpacingV5.s8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(SdSpacingV5.s6),
          child: Icon(
            iconData,
            color: iconColor,
            size: iconSize ?? SdSpacingV5.s24,
          ),
        ),
      ),
    );
  }
}
