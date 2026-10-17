import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// What a button means, passed as a prop — never a named constructor.
///
/// - [primary] — the screen's one CTA: add to bag, checkout, sign in.
/// - [secondary] — tonal, a supporting action.
/// - [outlined] — the alternative standing next to a primary.
/// - [text] — low emphasis ("Skip", "See all").
/// - [accent] — a promotion ("Shop the sale"), in the sale colour.
/// - [destructive] — an irreversible confirm.
enum SdButtonVariantV5 {
  primary,
  secondary,
  outlined,
  text,
  accent,
  destructive,
}

/// One shape at three sizes: [scale] multiplies the shared padding, glyph and
/// gap so a small button is the same pill, smaller.
enum SdButtonSizeV5 {
  small,
  medium,
  large;

  double get scale => switch (this) {
    SdButtonSizeV5.small => 0.72,
    SdButtonSizeV5.medium => 1,
    SdButtonSizeV5.large => 1.15,
  };
}

/// The one button for the whole app.
///
/// [busy] draws a spinner *over* the label, which is only made invisible, so
/// the pill keeps its width for the whole round trip and a double tap cannot
/// submit twice.
class SdButtonV5 extends StatelessWidget {
  const SdButtonV5({
    required this.variant,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.size = SdButtonSizeV5.medium,
    this.busy = false,
    this.expand = false,
    super.key,
  });

  final SdButtonVariantV5 variant;
  final String label;

  /// Null disables the button. So does [busy].
  final VoidCallback? onPressed;

  final IconData? icon;
  final IconData? trailingIcon;
  final SdButtonSizeV5 size;
  final bool busy;

  /// Stretches to the parent's width — a sheet's confirm, a form's submit.
  final bool expand;

  static double get iconGap => SdSpacingConstant.w8;

  bool get _enabled => onPressed != null && !busy;

  @override
  Widget build(BuildContext context) {
    final SdButtonStyleV5 style = SdButtonStyleV5.of(context, variant);
    final double scale = size.scale;
    final double glyphSize = SdIconV5.defaultSize * scale;
    final TextStyle labelStyle = context.textTheme5.labelLarge!.semiBold5
        .copyWith(
          color: style.foreground,
          fontSize:
              context.textTheme5.labelLarge!.fontSize! * scale.clamp(0.9, 1.1),
        );

    final Widget content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          SdIconV5(icon!, size: glyphSize, color: style.foreground),
          SizedBox(width: iconGap * scale),
        ],
        Flexible(
          child: Text(
            label,
            style: labelStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        if (trailingIcon != null) ...<Widget>[
          SizedBox(width: iconGap * scale),
          SdIconV5(trailingIcon!, size: glyphSize, color: style.foreground),
        ],
      ],
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      label: label,
      excludeSemantics: true,
      child: AnimatedOpacity(
        duration: SdMotionV5.fast,
        curve: SdMotionV5.standard,
        opacity: _enabled || busy ? 1 : SdButtonStyleV5.disabledOpacity,
        child: SdPressableV5(
          onTap: _enabled ? onPressed : null,
          child: AnimatedContainer(
            duration: SdMotionV5.of(context, SdMotionV5.normal),
            curve: SdMotionV5.standard,
            padding: SdContentPaddingV5.button * scale,
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: SdRadiusV5.buttonAll,
              border: style.border == null
                  ? null
                  : Border.fromBorderSide(style.border!),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(opacity: busy ? 0 : 1, child: content),
                if (busy)
                  Positioned.fill(
                    child: Center(
                      child: SizedBox.square(
                        dimension: glyphSize,
                        child: CircularProgressIndicator(
                          strokeWidth: SdSpacingConstant.w2,
                          color: style.foreground,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The colours a [SdButtonVariantV5] resolves to.
@immutable
class SdButtonStyleV5 {
  const SdButtonStyleV5({
    required this.background,
    required this.foreground,
    this.border,
  });

  static const double disabledOpacity = 0.4;

  final Color background;
  final Color foreground;
  final BorderSide? border;

  static SdButtonStyleV5 of(BuildContext context, SdButtonVariantV5 variant) {
    final ColorScheme colors = context.colorScheme5;

    return switch (variant) {
      SdButtonVariantV5.primary => SdButtonStyleV5(
        background: colors.primary,
        foreground: colors.onPrimary,
      ),
      SdButtonVariantV5.secondary => SdButtonStyleV5(
        background: context.sdTheme5.surfaceSunken,
        foreground: context.sdTheme5.textPrimary,
      ),
      SdButtonVariantV5.outlined => SdButtonStyleV5(
        background: Colors.transparent,
        foreground: context.sdTheme5.textPrimary,
        border: BorderSide(color: context.sdTheme5.textPrimary),
      ),
      SdButtonVariantV5.text => SdButtonStyleV5(
        background: Colors.transparent,
        foreground: context.sdTheme5.textPrimary,
      ),
      SdButtonVariantV5.accent => SdButtonStyleV5(
        background: context.sdTheme5.accent,
        foreground: context.sdTheme5.onAccent,
      ),
      SdButtonVariantV5.destructive => SdButtonStyleV5(
        background: colors.error,
        foreground: colors.onError,
      ),
    };
  }
}
