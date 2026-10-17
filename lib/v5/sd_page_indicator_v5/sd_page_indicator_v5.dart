import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';

/// Dots under a carousel; the current one stretches into a dash.
class SdPageIndicatorV5 extends StatelessWidget {
  const SdPageIndicatorV5({
    required this.count,
    required this.index,
    this.color,
    this.inactiveColor,
    super.key,
  });

  final int count;
  final int index;

  /// Override for a dot row laid over a photo.
  final Color? color;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: List<Widget>.generate(count, (int i) {
      final bool active = i == index;

      return AnimatedContainer(
        duration: SdMotionV5.of(context, SdMotionV5.normal),
        curve: SdMotionV5.standard,
        margin: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w2),
        width: active ? SdSpacingConstant.w20 : SdSpacingConstant.w6,
        height: SdSpacingConstant.r6,
        decoration: BoxDecoration(
          color: active
              ? (color ?? context.sdTheme5.textPrimary)
              : (inactiveColor ?? context.sdTheme5.border),
          borderRadius: SdRadiusV5.fullAll,
        ),
      );
    }),
  );
}
