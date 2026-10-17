import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';

/// A round colour choice for a product variant.
///
/// Selection is a ring *and* a check mark: two products in near-identical
/// navy and black must still be told apart, and colour cannot be the only
/// signal. The check picks black or white against the swatch so it stays
/// readable on a white tee and on a black one.
class SdColorSwatchV5 extends StatelessWidget {
  const SdColorSwatchV5({
    required this.color,
    required this.selected,
    required this.onSelected,
    required this.semanticLabel,
    this.size,
    super.key,
  });

  final Color color;
  final bool selected;
  final VoidCallback? onSelected;
  final String semanticLabel;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final double diameter = size ?? SdSpacingConstant.r32;
    final bool light = color.computeLuminance() > 0.6;

    return Semantics(
      selected: selected,
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: SdPressableV5(
        onTap: onSelected,
        pressedScale: 0.9,
        child: AnimatedContainer(
          duration: SdMotionV5.of(context, SdMotionV5.normal),
          curve: SdMotionV5.standard,
          padding: EdgeInsets.all(SdSpacingConstant.r3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.6,
              color: selected
                  ? context.sdTheme5.textPrimary
                  : Colors.transparent,
            ),
          ),
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: context.sdTheme5.border),
            ),
            child: AnimatedScale(
              scale: selected ? 1 : 0,
              duration: SdMotionV5.of(context, SdMotionV5.normal),
              curve: SdMotionV5.pop,
              child: SdIconV5(
                Symbols.check_rounded,
                size: diameter * 0.55,
                // Literal on purpose: the check contrasts with the product's
                // own colour, which no theme slot knows.
                color: light ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
