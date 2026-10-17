import 'package:flutter/material.dart';

import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_elevation_v5/sd_elevation_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';

/// Which layer a card sits on. [surface] is the default white card, [sunken]
/// a well, [outlined] a hairline frame with no fill.
enum SdCardLayerV5 { surface, sunken, outlined }

/// The one container for grouped content.
class SdCardV5 extends StatelessWidget {
  const SdCardV5({
    required this.child,
    this.layer = SdCardLayerV5.surface,
    this.padding,
    this.onTap,
    this.elevated = false,
    this.borderColor,
    this.semanticLabel,
    super.key,
  });

  final Widget child;
  final SdCardLayerV5 layer;

  /// Defaults to [SdContentPaddingV5.card]. Pass `EdgeInsets.zero` for a card
  /// whose child pads its own pieces.
  final EdgeInsets? padding;

  final VoidCallback? onTap;

  /// A soft shadow under the card, for a card floating over a photo or a
  /// sticky summary.
  final bool elevated;

  /// Overrides the frame colour — a selected card's outline.
  final Color? borderColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color background = switch (layer) {
      SdCardLayerV5.surface => context.sdTheme5.surface,
      SdCardLayerV5.sunken => context.sdTheme5.surfaceSunken,
      SdCardLayerV5.outlined => Colors.transparent,
    };
    final Color? frame =
        borderColor ??
        (layer == SdCardLayerV5.outlined ? context.sdTheme5.border : null);

    final Widget card = Container(
      padding: padding ?? SdContentPaddingV5.card,
      decoration: BoxDecoration(
        color: background,
        borderRadius: SdRadiusV5.cardAll,
        border: frame == null ? null : Border.all(color: frame),
        boxShadow: elevated ? SdElevationV5.medium(context) : null,
      ),
      child: child,
    );

    if (onTap == null) {
      return Semantics(label: semanticLabel, container: true, child: card);
    }

    return SdPressableV5(
      onTap: onTap,
      pressedScale: 0.98,
      semanticLabel: semanticLabel,
      child: card,
    );
  }
}
