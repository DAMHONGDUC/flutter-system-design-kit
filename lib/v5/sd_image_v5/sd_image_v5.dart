import 'package:flutter/material.dart';
import '../sd_colors_v5/sd_colors_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';

class SdImageV5 extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? borderRadiusValue;
  final String imagePath;

  const SdImageV5({
    super.key,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
    this.borderRadiusValue,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isRemoteImg = imagePath.startsWith('http');

    if (isRemoteImg) {
      // TODO: impl for remote img
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusValue ?? 0),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: boxFit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(borderRadiusValue ?? 0),
            ),
            child: SdIconV5(
              iconData: Icons.broken_image,
              color: SdColorsV5.grey,
            ),
          );
        },
      ),
    );
  }
}
