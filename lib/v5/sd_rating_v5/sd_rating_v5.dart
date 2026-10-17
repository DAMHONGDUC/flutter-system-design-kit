import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';

/// Five stars for a 0–5 [rating], half stars included. Display only — the
/// figure next to it is the caller's, so it can be localized.
class SdRatingV5 extends StatelessWidget {
  const SdRatingV5({
    required this.rating,
    required this.semanticLabel,
    this.size,
    super.key,
  });

  final double rating;
  final String semanticLabel;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final double star = size ?? SdSpacingConstant.r16;

    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(5, (int i) {
          final double left = rating - i;
          final IconData glyph = left >= 0.75
              ? Symbols.star_rounded
              : left >= 0.25
              ? Symbols.star_half_rounded
              : Symbols.star_rounded;
          final bool lit = left >= 0.25;

          return SdIconV5(
            glyph,
            size: star,
            fill: lit ? 1 : 0,
            color: lit ? context.sdTheme5.rating : context.sdTheme5.border,
          );
        }),
      ),
    );
  }
}
