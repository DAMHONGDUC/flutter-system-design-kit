import 'package:flutter/material.dart';
import '../index.dart';

enum SdButtonTypeV5 { primary, secondary }

enum SdButtonWidthV5 { full, fitContent }

enum SdButtonSizeV5 { small, medium, large }

/// Configuration class for button colors
class SdButtonColorConfigV5 {
  final Color primaryBgColor;
  final Color primaryTextColor;
  final Color secondaryBgColor;
  final Color secondaryTextColor;
  final Color secondaryBorderColor;
  final Color disabledBgColor;
  final Color disabledTextColor;

  factory SdButtonColorConfigV5.init() => SdButtonColorConfigV5(
    primaryBgColor: Colors.blue,
    primaryTextColor: SdColorsV5.white,
    secondaryBgColor: SdColorsV5.white,
    secondaryTextColor: Colors.blue,
    secondaryBorderColor: Colors.blue,
    disabledBgColor: SdColorsV5.grey300,
    disabledTextColor: SdColorsV5.grey500,
  );

  const SdButtonColorConfigV5({
    required this.primaryBgColor,
    required this.primaryTextColor,
    required this.secondaryBgColor,
    required this.secondaryTextColor,
    required this.secondaryBorderColor,
    required this.disabledBgColor,
    required this.disabledTextColor,
  });

  /// Create a custom color configuration
  SdButtonColorConfigV5 copyWith({
    Color? primaryBgColor,
    Color? primaryTextColor,
    Color? secondaryBgColor,
    Color? secondaryTextColor,
    Color? secondaryBorderColor,
    Color? disabledBgColor,
    Color? disabledTextColor,
  }) {
    return SdButtonColorConfigV5(
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryBgColor: secondaryBgColor ?? this.secondaryBgColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      secondaryBorderColor: secondaryBorderColor ?? this.secondaryBorderColor,
      disabledBgColor: disabledBgColor ?? this.disabledBgColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
    );
  }
}

class SdButtonV5 extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final SdButtonTypeV5 type;
  final SdButtonWidthV5 widthType;
  final bool isDisabled;
  final int titleMaxLines;
  final Widget? leading;
  final Widget? trailing;
  final String? subtitle;
  final double? height;
  final SdButtonColorConfigV5 colorConfig;
  final double? width;
  final double? borderRadiusValue;
  final SdButtonSizeV5 buttonSize;

  SdButtonV5({
    super.key,
    required this.title,
    this.onTap,
    this.type = SdButtonTypeV5.primary,
    this.widthType = SdButtonWidthV5.fitContent,
    this.isDisabled = false,
    this.titleMaxLines = 1,
    this.leading,
    this.trailing,
    this.subtitle,
    this.height,
    this.width,
    SdButtonColorConfigV5? colorConfig,
    this.borderRadiusValue,
    this.buttonSize = SdButtonSizeV5.medium,
  }) : colorConfig = colorConfig ?? SdButtonColorConfigV5.init();

  Color _getBackgroundColor() {
    if (isDisabled) {
      return colorConfig.disabledBgColor;
    }

    switch (type) {
      case SdButtonTypeV5.primary:
        return colorConfig.primaryBgColor;
      case SdButtonTypeV5.secondary:
        return colorConfig.secondaryBgColor;
    }
  }

  Color _getTextColor() {
    if (isDisabled) {
      return colorConfig.disabledTextColor;
    }

    switch (type) {
      case SdButtonTypeV5.primary:
        return colorConfig.primaryTextColor;
      case SdButtonTypeV5.secondary:
        return colorConfig.secondaryTextColor;
    }
  }

  Border? _getBorder() {
    if (type == SdButtonTypeV5.secondary && !isDisabled) {
      return Border.all(color: colorConfig.secondaryBorderColor, width: 1.5);
    }
    return null;
  }

  double getVerticalPadding() {
    switch (buttonSize) {
      case SdButtonSizeV5.small:
        return SdSpacingV5.s8;
      case SdButtonSizeV5.medium:
        return SdSpacingV5.s10;
      case SdButtonSizeV5.large:
        return SdSpacingV5.s12;
    }
  }

  double getHorizontalPadding() {
    double value = 0;

    switch (buttonSize) {
      case SdButtonSizeV5.small:
        value = SdSpacingV5.s12;
        break;
      case SdButtonSizeV5.medium:
        value = SdSpacingV5.s14;
        break;
      case SdButtonSizeV5.large:
        value = SdSpacingV5.s16;
        break;
    }

    return widthType == SdButtonWidthV5.fitContent ? value * 1.5 : value;
  }

  TextStyle getTitleTextStyle(Color textColor) {
    double textSize = SdSpacingV5.s14;

    switch (buttonSize) {
      case SdButtonSizeV5.small:
        textSize = SdSpacingV5.s12;
        break;
      case SdButtonSizeV5.medium:
        textSize = SdSpacingV5.s14;
        break;
      case SdButtonSizeV5.large:
        textSize = SdSpacingV5.s16;
        break;
    }

    return SdBaseTextStyleV5.base().copyWith(
      fontSize: textSize,
      color: textColor,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle getSubTitleTextStyle(Color textColor) {
    double textSize = SdSpacingV5.s14;

    switch (buttonSize) {
      case SdButtonSizeV5.small:
        textSize = SdSpacingV5.s10;
        break;
      case SdButtonSizeV5.medium:
        textSize = SdSpacingV5.s12;
        break;
      case SdButtonSizeV5.large:
        textSize = SdSpacingV5.s14;
        break;
    }

    return SdBaseTextStyleV5.base().copyWith(
      fontSize: textSize,
      color: textColor,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final border = _getBorder();
    final verticalPadding = getVerticalPadding();
    final horizontalPadding = getHorizontalPadding();
    final finalTitleTextStyle = getTitleTextStyle(textColor);
    final finalSubTitleTextStyle = getSubTitleTextStyle(SdColorsV5.grey200);

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: widthType == SdButtonWidthV5.fitContent
              ? MainAxisSize.min
              : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) ...[
              IconTheme(
                data: IconThemeData(color: textColor, size: 20),
                child: leading!,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              fit: widthType == SdButtonWidthV5.fitContent
                  ? FlexFit.loose
                  : FlexFit.tight,
              child: Text(
                title,
                style: finalTitleTextStyle,
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              IconTheme(
                data: IconThemeData(color: textColor, size: 20),
                child: trailing!,
              ),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: finalSubTitleTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );

    return SdInkWellV5(
      containerBg: bgColor,
      borderRadius: borderRadiusValue ?? SdSpacingV5.s100,
      border: border,
      onTap: isDisabled ? null : onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      height: height,
      width:
          width ?? (widthType == SdButtonWidthV5.full ? double.infinity : null),
      child: content,
    );
  }
}
