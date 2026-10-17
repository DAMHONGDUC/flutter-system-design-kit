import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_button_v5/sd_icon_button_v5.dart';

/// The v5 top bar: a back button when there is somewhere to go back to, a
/// centred title, and icon actions. Opaque, in the page colour, with no
/// shadow until content scrolls beneath it.
class SdAppBarV5 extends StatelessWidget implements PreferredSizeWidget {
  const SdAppBarV5({
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.bottom,
    this.backgroundColor,
    super.key,
  });

  final String? title;

  /// Replaces [title] — a logo, a search field.
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    final Widget? back =
        leading ??
        (automaticallyImplyLeading && canPop
            ? SdIconButtonV5(
                icon: Symbols.arrow_back_ios_new_rounded,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                size: SdSpacingConstant.r40,
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null);

    return AppBar(
      backgroundColor: backgroundColor ?? context.sdTheme5.background,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0.5,
      shadowColor: context.sdTheme5.shadow,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leadingWidth: SdSpacingConstant.w56,
      leading: back == null
          ? null
          : Padding(
              padding: EdgeInsets.only(left: SdSpacingConstant.w12),
              child: Center(child: back),
            ),
      title:
          titleWidget ??
          (title == null
              ? null
              : Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme5.titleMedium!.copyWith(
                    color: context.sdTheme5.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                )),
      actions: <Widget>[
        ...?actions,
        SizedBox(width: SdSpacingConstant.w8),
      ],
      bottom: bottom,
    );
  }
}
