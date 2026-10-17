import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A selectable pill — a size, a filter, a sort order, a category.
///
/// Selected is solid ink; unselected is an outline. The swap animates, so a
/// size picked on the product page is seen being picked. [enabled] false is
/// a size that is sold out: struck through, not just greyed, so the state is
/// never told by colour alone.
class SdChipV5 extends StatelessWidget {
  const SdChipV5({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    this.enabled = true,
    this.minWidth,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback? onSelected;
  final IconData? icon;
  final bool enabled;

  /// Size pickers pass a square minimum so `S` and `XL` are the same cell.
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Color foreground = selected ? context.sdTheme5.background : ink;

    return Semantics(
      selected: selected,
      enabled: enabled,
      button: true,
      label: label,
      excludeSemantics: true,
      child: SdPressableV5(
        onTap: enabled ? onSelected : null,
        pressedScale: 0.94,
        child: AnimatedContainer(
          duration: SdMotionV5.of(context, SdMotionV5.normal),
          curve: SdMotionV5.standard,
          constraints: BoxConstraints(minWidth: minWidth ?? 0),
          padding: EdgeInsets.symmetric(
            horizontal: SdSpacingConstant.w16,
            vertical: SdSpacingConstant.h10,
          ),
          decoration: BoxDecoration(
            color: selected ? ink : context.sdTheme5.surface,
            borderRadius: SdRadiusV5.chipAll,
            border: Border.all(color: selected ? ink : context.sdTheme5.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                SdIconV5(icon!, size: SdIconV5.smallSize, color: foreground),
                SizedBox(width: SdSpacingConstant.w6),
              ],
              Text(
                label,
                maxLines: 1,
                style: context.textTheme5.labelLarge!.semiBold5.copyWith(
                  color: enabled
                      ? foreground
                      : context.sdTheme5.textPlaceholder,
                  decoration: enabled ? null : TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
