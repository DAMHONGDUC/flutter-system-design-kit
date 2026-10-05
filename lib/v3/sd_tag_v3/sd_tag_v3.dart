import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v3/sd_context_v3.dart';
import '../sd_icon_v3/sd_icon_v3.dart';
import '../sd_radius_v3/sd_radius_v3.dart';
import '../sd_text_style_v3/sd_text_style_v3.dart';

/// One choice in a group of them — a radio wearing the colour of what it
/// selects.
///
/// **This is the picked-from-a-short-list control.** A status, a condition
/// grade: a handful of values that are the answer to one question, where
/// hiding them behind a row that opens a sheet costs two taps to see what the
/// choices even are. Laid out as tags, the whole vocabulary reads at once.
///
/// **[color] is handed in, never decided here** — the package does not learn
/// what a domain value means (`WIDGET_RULES.md` §1). The app maps its enum to
/// a colour and passes it, which is also what lets every value in a set carry
/// a different one.
///
/// **The hue is in the radio, never the border.** Chosen is told in ink — an
/// ink border, an ink label, a sunken ground. The radio wears [color] either
/// way — hollow before the pick, filled after — so every option shows its
/// hue, and a viewer who cannot tell hues apart still sees which is chosen.
class SdTagV3 extends StatelessWidget {
  const SdTagV3({
    required this.label,
    required this.color,
    required this.selected,
    required this.onSelected,
    this.icon,
    this.showSelectionIndicator = true,
    super.key,
  });

  final String label;

  /// This value's hue, worn by its radio, glyph or dot.
  final Color color;

  final bool selected;
  final VoidCallback onSelected;

  /// An optional glyph in place of the radio, for a group whose values are
  /// recognised faster by shape than by a dot.
  final IconData? icon;

  /// Whether a tag with no explicit [icon] draws its selected/unselected
  /// radio. Display-only tags turn this off and draw a dot in [color].
  final bool showSelectionIndicator;

  /// The dot a display-only tag draws — what the tag is, not configuration.
  static double get dotSize => SdSpacingConstant.w8;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme3.textPrimary;
    final Color foreground = selected ? ink : context.sdTheme3.textSecondary;
    final IconData? leadingIcon =
        icon ??
        (showSelectionIndicator
            ? selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded
            : null);
    final Widget mark = leadingIcon != null
        ? SdIconV3(leadingIcon, size: SdIconV3.smallSize, color: color)
        : Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: SdRadiusV3.chipAll,
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: SdSpacingConstant.w12,
            vertical: SdSpacingConstant.h8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? context.sdTheme3.surfaceSunken
                : Colors.transparent,
            borderRadius: SdRadiusV3.chipAll,
            border: Border.all(color: selected ? ink : context.sdTheme3.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              mark,
              SizedBox(width: SdSpacingConstant.w6),
              Text(
                label,
                style: context.textTheme3.bodySmall!.semiBold3.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
