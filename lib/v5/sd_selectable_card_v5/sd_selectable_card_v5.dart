import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A radio choice dressed as a card — a shipping address, a delivery speed,
/// a payment method. Selection is a frame *and* a filled radio.
class SdSelectableCardV5 extends StatelessWidget {
  const SdSelectableCardV5({
    required this.title,
    required this.selected,
    required this.onSelected,
    this.subtitle,
    this.icon,
    this.leading,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;

  /// Artwork in the icon's place — a card network logo.
  final Widget? leading;

  /// A price on a delivery option, an "Edit" on an address.
  final Widget? trailing;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Duration duration = SdMotionV5.of(context, SdMotionV5.normal);

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      button: true,
      child: SdPressableV5(
        onTap: onSelected,
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: duration,
          curve: SdMotionV5.standard,
          padding: SdContentPaddingV5.card,
          decoration: BoxDecoration(
            color: context.sdTheme5.surface,
            borderRadius: SdRadiusV5.cardAll,
            border: Border.all(
              color: selected ? ink : context.sdTheme5.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              if (leading != null || icon != null) ...<Widget>[
                SizedBox.square(
                  dimension: SdSpacingConstant.r40,
                  child:
                      leading ??
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.sdTheme5.surfaceSunken,
                          borderRadius: SdRadiusV5.thumbnailAll,
                        ),
                        child: Center(child: SdIconV5(icon!)),
                      ),
                ),
                SizedBox(width: SdSpacingConstant.w12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.textTheme5.bodyLarge!.semiBold5.copyWith(
                        color: ink,
                      ),
                    ),
                    if (subtitle != null) ...<Widget>[
                      SizedBox(height: SdSpacingConstant.h2),
                      Text(
                        subtitle!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme5.bodySmall!.muted5(context),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...<Widget>[
                SizedBox(width: SdSpacingConstant.w8),
                trailing!,
              ],
              SizedBox(width: SdSpacingConstant.w12),
              AnimatedContainer(
                duration: duration,
                width: SdSpacingConstant.r22,
                height: SdSpacingConstant.r22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? ink : context.sdTheme5.border,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: AnimatedScale(
                    scale: selected ? 1 : 0,
                    duration: duration,
                    curve: SdMotionV5.pop,
                    child: Container(
                      width: SdSpacingConstant.r12,
                      height: SdSpacingConstant.r12,
                      decoration: BoxDecoration(
                        color: ink,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
