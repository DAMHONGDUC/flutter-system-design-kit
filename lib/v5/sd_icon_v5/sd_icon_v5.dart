import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';

/// Every glyph v5 draws. Always a concrete size — an icon never inherits an
/// ambient one — and [fill] because Material Symbols is a variable font: a
/// selected tab and an unselected one are one glyph at two fill values.
class SdIconV5 extends StatelessWidget {
  const SdIconV5(
    this.icon, {
    this.size,
    this.color,
    this.fill,
    this.semanticLabel,
    super.key,
  });

  static double get defaultSize => SdSpacingConstant.r20;

  static double get largeSize => SdSpacingConstant.r24;

  static double get smallSize => SdSpacingConstant.r16;

  final IconData icon;
  final double? size;
  final Color? color;
  final double? fill;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Icon(
    icon,
    size: size ?? defaultSize,
    color: color ?? context.sdTheme5.textPrimary,
    fill: fill,
    semanticLabel: semanticLabel,
  );
}
