import 'package:flutter/widgets.dart';

import '../../core/sd_spacing_constant.dart';

/// Semantic corner radii. A call site names what it rounds, never a number.
final class SdRadiusV5 {
  static double get chip => SdSpacingConstant.r999;

  static double get input => SdSpacingConstant.r16;

  static double get card => SdSpacingConstant.r20;

  /// Product photos inside a card — one step tighter than the card so the
  /// photo reads as sitting inside it.
  static double get photo => SdSpacingConstant.r16;

  static double get button => SdSpacingConstant.r999;

  static double get modal => SdSpacingConstant.r28;

  static double get thumbnail => SdSpacingConstant.r12;

  static double get skeleton => SdSpacingConstant.r8;

  static double get full => SdSpacingConstant.r999;

  static BorderRadius get chipAll => BorderRadius.circular(chip);
  static BorderRadius get inputAll => BorderRadius.circular(input);
  static BorderRadius get cardAll => BorderRadius.circular(card);
  static BorderRadius get photoAll => BorderRadius.circular(photo);
  static BorderRadius get buttonAll => BorderRadius.circular(button);
  static BorderRadius get thumbnailAll => BorderRadius.circular(thumbnail);
  static BorderRadius get skeletonAll => BorderRadius.circular(skeleton);
  static BorderRadius get fullAll => BorderRadius.circular(full);

  static BorderRadius get modalTop =>
      BorderRadius.vertical(top: Radius.circular(modal));
}
