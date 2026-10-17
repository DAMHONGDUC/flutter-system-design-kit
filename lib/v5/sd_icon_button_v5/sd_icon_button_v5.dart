import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_count_badge_v5/sd_count_badge_v5.dart';
import '../sd_elevation_v5/sd_elevation_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';

/// How an [SdIconButtonV5] is filled.
///
/// - [plain] — glyph only, for an app bar.
/// - [tonal] — a sunken circle, for a toolbar on the page.
/// - [filled] — the primary colour, for the one icon action of a row.
/// - [floating] — a surface circle with a shadow, for a control laid over a
///   photo (back, share, wishlist on the product gallery).
enum SdIconButtonVariantV5 { plain, tonal, filled, floating }

/// A circular icon action, optionally carrying a [SdCountBadgeV5].
class SdIconButtonV5 extends StatelessWidget {
  const SdIconButtonV5({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.variant = SdIconButtonVariantV5.plain,
    this.badgeCount = 0,
    this.color,
    this.fill,
    this.size,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final SdIconButtonVariantV5 variant;
  final int badgeCount;
  final Color? color;
  final double? fill;

  /// The circle's diameter. The glyph scales with it.
  final double? size;

  static double get defaultSize => SdSpacingConstant.r44;

  @override
  Widget build(BuildContext context) {
    final double diameter = size ?? defaultSize;
    final Color background = switch (variant) {
      SdIconButtonVariantV5.plain => Colors.transparent,
      SdIconButtonVariantV5.tonal => context.sdTheme5.surfaceSunken,
      SdIconButtonVariantV5.filled => context.colorScheme5.primary,
      SdIconButtonVariantV5.floating => context.sdTheme5.surface,
    };
    final Color foreground =
        color ??
        (variant == SdIconButtonVariantV5.filled
            ? context.colorScheme5.onPrimary
            : context.sdTheme5.textPrimary);

    return Tooltip(
      message: tooltip,
      child: SdPressableV5(
        onTap: onPressed,
        pressedScale: 0.9,
        semanticLabel: tooltip,
        child: SizedBox.square(
          dimension: diameter,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                    boxShadow: variant == SdIconButtonVariantV5.floating
                        ? SdElevationV5.low(context)
                        : null,
                  ),
                  child: Center(
                    child: SdIconV5(
                      icon,
                      size: diameter * 0.5,
                      color: onPressed == null
                          ? context.sdTheme5.textPlaceholder
                          : foreground,
                      fill: fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: diameter * 0.04,
                right: diameter * 0.02,
                child: SdCountBadgeV5(count: badgeCount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
