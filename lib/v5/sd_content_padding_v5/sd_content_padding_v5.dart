import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../core/sd_spacing_constant.dart';

/// Every inset a v5 screen lays out by. Anything another widget pads by lives
/// here — a number typed at a call site is how a bar and the padding beneath
/// it drift apart.
abstract final class SdContentPaddingV5 {
  /// The page gutter.
  static double get horizontal => SdSpacingConstant.w20;

  static double get sectionGap => SdSpacingConstant.h28;

  static double get itemGap => SdSpacingConstant.h12;

  /// The gap between two columns of a product grid.
  static double get gridGap => SdSpacingConstant.w14;

  static EdgeInsets get card => EdgeInsets.all(SdSpacingConstant.w16);

  static EdgeInsets get row => EdgeInsets.symmetric(
    horizontal: SdSpacingConstant.w16,
    vertical: SdSpacingConstant.h14,
  );

  static EdgeInsets get button => EdgeInsets.symmetric(
    horizontal: SdSpacingConstant.w24,
    vertical: SdSpacingConstant.h14,
  );

  static EdgeInsets get gutter => EdgeInsets.symmetric(horizontal: horizontal);

  // --- The floating tab bar ---

  static double get navBarHeight => SdSpacingConstant.h64;

  static double get navBarMargin => SdSpacingConstant.w20;

  /// Where the floating bar sits above the bottom edge: the home indicator
  /// when there is one, a fixed floor when there is not.
  static double navBarOffset(BuildContext context) =>
      math.max(_viewBottom(context), SdSpacingConstant.h16);

  /// What a tab screen pads its scroll view by so the last row clears the bar.
  static double aboveNavBar(BuildContext context) =>
      navBarOffset(context) + navBarHeight + SdSpacingConstant.h16;

  /// The bottom inset of a screen with nothing floating over it.
  static double detailBottom(BuildContext context) =>
      math.max(_viewBottom(context), SdSpacingConstant.h16);

  static double statusBarInset(BuildContext context) =>
      MediaQuery.paddingOf(context).top;

  static double keyboardInset(BuildContext context) =>
      MediaQuery.viewInsetsOf(context).bottom;

  static double _viewBottom(BuildContext context) =>
      MediaQuery.viewPaddingOf(context).bottom;
}
