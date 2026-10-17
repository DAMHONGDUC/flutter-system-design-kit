import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// A section title with an optional "See all" on the far end.
class SdSectionHeaderV5 extends StatelessWidget {
  const SdSectionHeaderV5({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Anything else at the far end — a countdown on a flash-sale row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme5.titleLarge!.copyWith(
                color: context.sdTheme5.textPrimary,
              ),
            ),
            if (subtitle != null) ...<Widget>[
              SizedBox(height: SdSpacingConstant.h2),
              Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme5.bodySmall!.muted5(context),
              ),
            ],
          ],
        ),
      ),
      ?trailing,
      if (actionLabel != null && onAction != null)
        SdPressableV5(
          onTap: onAction,
          semanticLabel: actionLabel,
          child: Padding(
            padding: EdgeInsets.only(
              left: SdSpacingConstant.w12,
              top: SdSpacingConstant.h4,
              bottom: SdSpacingConstant.h2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  actionLabel!,
                  style: context.textTheme5.labelLarge!.semiBold5.copyWith(
                    color: context.sdTheme5.textSecondary,
                  ),
                ),
                SdIconV5(
                  Symbols.chevron_right_rounded,
                  size: SdIconV5.smallSize,
                  color: context.sdTheme5.textSecondary,
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
