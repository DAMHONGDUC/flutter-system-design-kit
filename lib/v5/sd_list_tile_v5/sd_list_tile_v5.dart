import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A settings / menu row: an icon in a soft tile, a title and subtitle, and a
/// trailing control — a chevron by default when the row navigates.
class SdListTileV5 extends StatelessWidget {
  const SdListTileV5({
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trailing,
    this.onTap,
    this.destructive = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  /// Replaces the chevron — a switch, a value, a badge.
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Sign out: the title and glyph in the danger colour.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final Color tint = destructive
        ? context.sdTheme5.danger
        : iconColor ?? context.sdTheme5.textPrimary;

    final Widget row = Padding(
      padding: SdContentPaddingV5.row,
      child: Row(
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Container(
              width: SdSpacingConstant.r40,
              height: SdSpacingConstant.r40,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.08),
                borderRadius: SdRadiusV5.thumbnailAll,
              ),
              child: Center(child: SdIconV5(icon!, color: tint)),
            ),
            SizedBox(width: SdSpacingConstant.w14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme5.bodyLarge!.semiBold5.copyWith(
                    color: destructive
                        ? context.sdTheme5.danger
                        : context.sdTheme5.textPrimary,
                  ),
                ),
                if (subtitle != null) ...<Widget>[
                  SizedBox(height: SdSpacingConstant.h2),
                  Text(
                    subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme5.bodySmall!.muted5(context),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else if (onTap != null)
            SdIconV5(
              Symbols.chevron_right_rounded,
              color: context.sdTheme5.textTertiary,
            ),
        ],
      ),
    );

    if (onTap == null) return row;

    return SdPressableV5(onTap: onTap, pressedScale: 0.985, child: row);
  }
}
