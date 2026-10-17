import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A small number pinned to an icon — items in the bag, unread messages.
///
/// Hidden at zero. When the count changes the new figure pops in, so adding
/// to the bag is seen on the bag icon itself, not only in a toast.
class SdCountBadgeV5 extends StatelessWidget {
  const SdCountBadgeV5({required this.count, this.max = 99, super.key});

  final int count;

  /// Above this the badge reads `99+`.
  final int max;

  @override
  Widget build(BuildContext context) {
    final String text = count > max ? '$max+' : '$count';

    return AnimatedSwitcher(
      duration: SdMotionV5.of(context, SdMotionV5.normal),
      switchInCurve: SdMotionV5.pop,
      switchOutCurve: SdMotionV5.exit,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(scale: animation, child: child),
      child: count <= 0
          ? const SizedBox.shrink()
          : Container(
              key: ValueKey<int>(count),
              constraints: BoxConstraints(
                minWidth: SdSpacingConstant.r18,
                minHeight: SdSpacingConstant.r18,
              ),
              padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w4),
              decoration: BoxDecoration(
                color: context.sdTheme5.accent,
                borderRadius: BorderRadius.circular(SdSpacingConstant.r999),
                border: Border.all(
                  color: context.sdTheme5.surface,
                  width: SdSpacingConstant.w2 * 0.75,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: context.textTheme5.labelSmall!.bold5.tabular5.copyWith(
                  color: context.sdTheme5.onAccent,
                  height: 1.1,
                ),
              ),
            ),
    );
  }
}
