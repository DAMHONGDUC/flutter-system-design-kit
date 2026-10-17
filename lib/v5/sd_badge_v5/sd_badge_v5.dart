import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// What a badge says about its subject.
///
/// [accent] is the sale colour (−30%), [inverse] the solid ink pill (NEW),
/// [neutral] a quiet tag; the rest are statuses. Colour is never the only
/// signal — every badge carries its words.
enum SdBadgeToneV5 { neutral, inverse, accent, success, warning, danger, info }

/// A short label pill: a discount, NEW, an order status.
class SdBadgeV5 extends StatelessWidget {
  const SdBadgeV5({
    required this.label,
    this.tone = SdBadgeToneV5.neutral,
    this.icon,
    this.solid = false,
    super.key,
  });

  final String label;
  final SdBadgeToneV5 tone;
  final IconData? icon;

  /// A filled pill rather than a tinted one — for a badge laid over a photo,
  /// where a tint would vanish into the picture.
  final bool solid;

  @override
  Widget build(BuildContext context) {
    final Color tint = switch (tone) {
      SdBadgeToneV5.neutral => context.sdTheme5.textSecondary,
      SdBadgeToneV5.inverse => context.sdTheme5.textPrimary,
      SdBadgeToneV5.accent => context.sdTheme5.accent,
      SdBadgeToneV5.success => context.sdTheme5.success,
      SdBadgeToneV5.warning => context.sdTheme5.warning,
      SdBadgeToneV5.danger => context.sdTheme5.danger,
      SdBadgeToneV5.info => context.sdTheme5.info,
    };
    final bool filled = solid || tone == SdBadgeToneV5.inverse;
    final Color foreground = !filled
        ? tint
        : tone == SdBadgeToneV5.inverse
        ? context.sdTheme5.background
        : context.sdTheme5.onAccent;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SdSpacingConstant.w8,
        vertical: SdSpacingConstant.h4,
      ),
      decoration: BoxDecoration(
        color: filled ? tint : tint.withValues(alpha: 0.12),
        borderRadius: SdRadiusV5.chipAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            SdIconV5(icon!, size: SdSpacingConstant.r12, color: foreground),
            SizedBox(width: SdSpacingConstant.w4),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme5.labelSmall!.bold5.copyWith(
              color: foreground,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
