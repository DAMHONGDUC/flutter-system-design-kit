import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_button_v5/sd_button_v5.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// One button of an [SdDialogV5].
class SdDialogActionV5 {
  const SdDialogActionV5({
    required this.label,
    required this.onPressed,
    this.variant = SdButtonVariantV5.text,
  });

  final String label;
  final VoidCallback onPressed;
  final SdButtonVariantV5 variant;
}

/// A centred confirm: glyph, title, message, and actions stacked full width
/// — stacked, not side by side, so a long Vietnamese label never wraps.
class SdDialogV5 extends StatelessWidget {
  const SdDialogV5({
    required this.title,
    required this.actions,
    this.message,
    this.icon,
    this.iconColor,
    super.key,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final List<SdDialogActionV5> actions;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: context.sdTheme5.surface,
    surfaceTintColor: Colors.transparent,
    insetPadding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w32),
    shape: RoundedRectangleBorder(borderRadius: SdRadiusV5.cardAll),
    child: Padding(
      padding: EdgeInsets.all(SdSpacingConstant.w24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Center(
              child: Container(
                width: SdSpacingConstant.r56,
                height: SdSpacingConstant.r56,
                decoration: BoxDecoration(
                  color: (iconColor ?? context.sdTheme5.textPrimary).withValues(
                    alpha: 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SdIconV5(
                    icon!,
                    size: SdIconV5.largeSize,
                    color: iconColor ?? context.sdTheme5.textPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(height: SdSpacingConstant.h16),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme5.titleLarge!.copyWith(
              color: context.sdTheme5.textPrimary,
            ),
          ),
          if (message != null) ...<Widget>[
            SizedBox(height: SdSpacingConstant.h8),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: context.textTheme5.bodyMedium!.muted5(context),
            ),
          ],
          SizedBox(height: SdSpacingConstant.h24),
          for (final (int i, SdDialogActionV5 action)
              in actions.indexed) ...<Widget>[
            if (i > 0) SizedBox(height: SdContentPaddingV5.itemGap * 0.66),
            SdButtonV5(
              variant: action.variant,
              label: action.label,
              onPressed: action.onPressed,
              expand: true,
            ),
          ],
        ],
      ),
    ),
  );
}

/// Presents an [SdDialogV5] with a scale-and-fade entrance.
Future<T?> showSdDialogV5<T>(BuildContext context, SdDialogV5 dialog) =>
    showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: context.sdTheme5.barrier,
      transitionDuration: SdMotionV5.of(context, SdMotionV5.normal),
      pageBuilder:
          (BuildContext context, Animation<double> _, Animation<double> _) =>
              dialog,
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> _,
            Widget child,
          ) {
            final Animation<double> curved = CurvedAnimation(
              parent: animation,
              curve: SdMotionV5.pop,
              reverseCurve: SdMotionV5.exit,
            );

            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
                child: child,
              ),
            );
          },
    );
