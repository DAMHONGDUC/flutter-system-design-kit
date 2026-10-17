import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A round portrait, or the caller's [initials] on a sunken disc when there
/// is no photo.
class SdAvatarV5 extends StatelessWidget {
  const SdAvatarV5({
    required this.initials,
    this.image,
    this.size,
    this.ringColor,
    super.key,
  });

  final String initials;
  final ImageProvider? image;
  final double? size;

  /// A ring around the portrait — the profile header's.
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    final double diameter = size ?? SdSpacingConstant.r44;

    return Container(
      width: diameter,
      height: diameter,
      padding: ringColor == null ? null : EdgeInsets.all(SdSpacingConstant.r3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: ringColor == null
            ? null
            : Border.all(color: ringColor!, width: 2),
      ),
      child: ClipOval(
        child: image != null
            ? Image(image: image!, fit: BoxFit.cover)
            : ColoredBox(
                color: context.sdTheme5.surfaceSunken,
                child: Center(
                  child: Text(
                    initials,
                    style: context.textTheme5.titleMedium!.bold5.copyWith(
                      color: context.sdTheme5.textPrimary,
                      fontSize: diameter * 0.36,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
