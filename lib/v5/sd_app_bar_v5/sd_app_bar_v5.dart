import 'package:flutter/material.dart';

import '../index.dart';

class SdAppBarV5 extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool showBackButton;
  final Color? textColor;
  final Color? shadowColor;
  final Color? backButtonContainerBg;
  final Color? backButtonIconColor;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final bool noElevation;
  final double titleSpacing;
  final EdgeInsetsGeometry? actionPadding;

  const SdAppBarV5({
    super.key,
    this.titleText,
    this.actions,
    this.backgroundColor,
    this.centerTitle = false,
    this.showBackButton = true,
    this.textColor,
    this.shadowColor,
    this.backButtonContainerBg,
    this.backButtonIconColor,
    this.titleWidget,
    this.bottom,
    this.noElevation = false,
    this.titleSpacing = SdSpacingV5.s12,
    this.actionPadding,
  });

  @override
  Widget build(BuildContext context) {
    final finalActionPadding =
        actionPadding ?? EdgeInsets.only(right: titleSpacing);

    return AppBar(
      title:
          titleWidget ??
          (titleText != null
              ? Text(
                  titleText!,
                  style: SdTextStyleV5.heading16().copyWith(color: textColor),
                )
              : null),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: SdColorsV5.transparent,
      actions: actions,
      leading: showBackButton
          ? SdInkWellV5(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: SdIconV5(
                iconData: SdHelperV5.getAppBarBackIcon(),
                iconSize: SdSpacingV5.s20,
                color: backButtonIconColor,
              ),
            )
          : null,
      titleSpacing: titleSpacing,
      actionsPadding: finalActionPadding,
      elevation: noElevation ? 0 : SdSpacingV5.s1,
      shadowColor: noElevation
          ? Colors.transparent
          : (shadowColor ?? SdColorsV5.black54),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
