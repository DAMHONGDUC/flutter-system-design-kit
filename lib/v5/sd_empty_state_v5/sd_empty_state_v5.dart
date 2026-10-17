import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// Nothing here yet: an empty bag, no search results, no orders. A glyph in a
/// soft disc, a title, a line of help and an optional action — which settle
/// in rather than appear, so an empty screen reads as an answer, not a gap.
class SdEmptyStateV5 extends StatelessWidget {
  const SdEmptyStateV5({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween<double>(begin: 0, end: 1),
    duration: SdMotionV5.of(context, SdMotionV5.slow),
    curve: SdMotionV5.standard,
    builder: (BuildContext context, double t, Widget? child) => Opacity(
      opacity: t,
      child: Transform.translate(
        offset: Offset(0, (1 - t) * SdSpacingConstant.h16),
        child: child,
      ),
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: SdSpacingConstant.r88,
              height: SdSpacingConstant.r88,
              decoration: BoxDecoration(
                color: context.sdTheme5.surfaceSunken,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SdIconV5(
                  icon,
                  size: SdSpacingConstant.r36,
                  color: context.sdTheme5.textSecondary,
                ),
              ),
            ),
            SizedBox(height: SdSpacingConstant.h20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme5.titleLarge!.copyWith(
                color: context.sdTheme5.textPrimary,
              ),
            ),
            if (message != null) ...<Widget>[
              SizedBox(height: SdSpacingConstant.h8),
              Text(
                message!,
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme5.bodyMedium!.muted5(context),
              ),
            ],
            if (action != null) ...<Widget>[
              SizedBox(height: SdSpacingConstant.h24),
              action!,
            ],
          ],
        ),
      ),
    ),
  );
}
