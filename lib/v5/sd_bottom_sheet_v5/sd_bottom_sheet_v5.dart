import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_button_v5/sd_icon_button_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';

/// A sheet's chrome: grabber, title, close button, and a body that scrolls
/// when it outgrows the screen. The footer (a confirm button) stays pinned
/// above the home indicator and the keyboard.
class SdBottomSheetV5 extends StatelessWidget {
  const SdBottomSheetV5({
    required this.title,
    required this.closeTooltip,
    required this.child,
    this.footer,
    this.trailing,
    super.key,
  });

  final String title;
  final String closeTooltip;
  final Widget child;
  final Widget? footer;

  /// An action left of the close button — "Reset" on a filter sheet.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final double bottom =
        SdContentPaddingV5.detailBottom(context) +
        SdContentPaddingV5.keyboardInset(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      decoration: BoxDecoration(
        color: context.sdTheme5.surface,
        borderRadius: SdRadiusV5.modalTop,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: SdSpacingConstant.h8),
          Center(
            child: Container(
              width: SdSpacingConstant.w40,
              height: SdSpacingConstant.h4,
              decoration: BoxDecoration(
                color: context.sdTheme5.border,
                borderRadius: SdRadiusV5.fullAll,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              SdContentPaddingV5.horizontal,
              SdSpacingConstant.h8,
              SdSpacingConstant.w8,
              SdSpacingConstant.h4,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme5.titleLarge!.copyWith(
                      color: context.sdTheme5.textPrimary,
                    ),
                  ),
                ),
                ?trailing,
                SdIconButtonV5(
                  icon: Symbols.close_rounded,
                  tooltip: closeTooltip,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                SdContentPaddingV5.horizontal,
                SdSpacingConstant.h8,
                SdContentPaddingV5.horizontal,
                footer == null ? bottom : SdSpacingConstant.h16,
              ),
              child: child,
            ),
          ),
          if (footer != null)
            Container(
              padding: EdgeInsets.fromLTRB(
                SdContentPaddingV5.horizontal,
                SdSpacingConstant.h12,
                SdContentPaddingV5.horizontal,
                bottom,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: context.sdTheme5.divider),
                ),
              ),
              child: footer,
            ),
        ],
      ),
    );
  }
}

/// Presents a v5 sheet: transparent route so the sheet's own corners show,
/// the theme's barrier, drag to dismiss.
Future<T?> showSdBottomSheetV5<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool dismissible = true,
}) => showModalBottomSheet<T>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  useRootNavigator: true,
  isDismissible: dismissible,
  enableDrag: dismissible,
  backgroundColor: Colors.transparent,
  barrierColor: context.sdTheme5.barrier,
  elevation: 0,
  builder: builder,
);
