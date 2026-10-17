import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';

/// Weight and tone modifiers for a [TextStyle] already read from the theme.
/// Suffixed like every v5 member, see `SdContextV5X`.
extension SdTextStyleV5X on TextStyle {
  TextStyle get medium5 => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold5 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold5 => copyWith(fontWeight: FontWeight.w700);

  TextStyle muted5(BuildContext context) =>
      copyWith(color: context.sdTheme5.textSecondary);

  TextStyle faint5(BuildContext context) =>
      copyWith(color: context.sdTheme5.textTertiary);

  TextStyle tinted5(Color color) => copyWith(color: color);

  /// Figures that do not jiggle when a price or a countdown changes.
  TextStyle get tabular5 =>
      copyWith(fontFeatures: const <FontFeature>[FontFeature.tabularFigures()]);

  /// A compare-at price.
  TextStyle get struck5 => copyWith(decoration: TextDecoration.lineThrough);
}
