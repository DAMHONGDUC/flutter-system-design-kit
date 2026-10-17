import 'package:color_shade/color_shade.dart';
import 'package:flutter/material.dart';

// SdColorsV5 is a class that contains fixed colors such as red, green, and blue, rather than semantic colors like primary, secondary, or iconColor,...
// 50: Very light tint of the color.
// 100: Light tint of the color.
// 200: Lighter shade, slightly darker than the previous one.
// 300: Light shade.
// 400: Standard shade, typically used for primary elements.
// 500: Primary color.
// 600: Dark shade, slightly darker than the primary color.
// 700: Darker shade.
// 800: Very dark shade.
// 900: The darkest shade of the color.

class SdColorsV5 {
  SdColorsV5._();

  // Base Colors
  static const Color transparent = Colors.transparent;

  // White Tones
  static const Color white = Color(0xFFFFFFFF);

  // Grey Tones
  static const Color grey = Colors.grey;
  static final Color grey50 = grey.shade50;
  static final Color grey100 = grey.shade100;
  static final Color grey200 = grey.shade200;
  static final Color grey300 = grey.shade300;
  static final Color grey400 = grey.shade400;
  static final Color grey500 = grey.shade500;
  static final Color grey600 = grey.shade600;
  static final Color grey700 = grey.shade700;
  static final Color grey800 = grey.shade800;
  static final Color grey900 = grey.shade900;

  // Black Tones
  static const Color black = Colors.black;
  static final Color black50 = black.shade50;
  static final Color black100 = black.shade100;
  static final Color black200 = black.shade200;
  static final Color black300 = black.shade300;
  static final Color black400 = black.shade400;
  static final Color black500 = black.shade500;
  static final Color black600 = black.shade600;
  static final Color black700 = black.shade700;
  static final Color black800 = black.shade800;
  static final Color black900 = black.shade900;

  // Red Tones
  static const Color red = Color(0xFFF00000);
  static final Color red50 = red.shade50;
  static final Color red100 = red.shade100;
  static final Color red200 = red.shade200;
  static final Color red300 = red.shade300;
  static final Color red400 = red.shade400;
  static final Color red500 = red.shade500;
  static final Color red600 = red.shade600;
  static final Color red700 = red.shade700;
  static final Color red800 = red.shade800;
  static final Color red900 = red.shade900;

  // Other
  static final Color black54 = Colors.black54;
  static final Color black12 = Colors.black12;

  static final Color grey5 = grey.withValues(alpha: 0.05);
}
