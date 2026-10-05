import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v3/sd_context_v3.dart';
import '../sd_elevation_v3/sd_elevation_v3.dart';
import '../sd_icon_v3/sd_icon_v3.dart';

/// The floating action button — Quick Add, and whatever each screen's one
/// primary create action turns out to be.
///
/// **A glyph in a filled circle, with no title and no animation.** A
/// labelled pill over a floating glass tab bar is a slab covering rows of
/// inventory, and one that changes width while the list moves is a target the
/// thumb has to find again. The circle is [size] across and never changes.
///
/// [label] is never painted; it is what a screen reader announces, so the
/// button is not anonymous to someone who cannot see the glyph.
///
/// It never disappears. A create action a seller has to scroll to find is one
/// they stop using, and Quick Add is the feature the whole product's speed
/// rests on.
///
/// The caller owns where it sits. Over a floating tab bar it must be lifted
/// by `SdContentPaddingV3.floatingBarInset`, or `extendBody` renders it
/// *behind* the glass.
class SdFabV3 extends StatelessWidget {
  const SdFabV3({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final IconData icon;

  /// The semantics label — what the button does, already localized.
  final String label;

  final VoidCallback onPressed;

  /// The circle's diameter. Two steps under Material's 56: this button sits
  /// above a 64pt glass bar, and the two stacked are the whole bottom of the
  /// screen.
  static double get size => SdSpacingConstant.h48;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme3;

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: SdElevationV3.raised(context),
        ),
        child: Material(
          color: colors.primary,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: size,
              child: Center(child: SdIconV3(icon, color: colors.onPrimary)),
            ),
          ),
        ),
      ),
    );
  }
}
