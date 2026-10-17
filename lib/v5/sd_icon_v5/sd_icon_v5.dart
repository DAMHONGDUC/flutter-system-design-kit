import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/text_ext.dart';
import '../index.dart';

class SdIconV5 extends StatelessWidget {
  const SdIconV5({
    super.key,
    this.iconData,
    this.iconPath,
    this.iconSize,
    this.color,
  });

  final IconData? iconData;
  final String? iconPath;
  final double? iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = iconSize ?? SdSpacingV5.s24;
    final iconColor = color ?? SdColorsV5.grey600;

    if (iconData != null) {
      return Icon(iconData, color: iconColor, size: size);
    }

    if (iconPath.isNotNullAndNotEmpty) {
      if (iconPath!.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          iconPath!,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        );
      } else {
        return Image.asset(iconPath!, width: size, height: size);
      }
    }

    return const SizedBox.shrink();
  }
}
