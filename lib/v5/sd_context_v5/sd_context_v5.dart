import 'package:flutter/material.dart';

import '../sd_theme_v5/sd_theme_v5.dart';

/// v5's theme lookups. Every member carries the `5` suffix so a file that
/// imports the package index gets every generation's extension without one
/// shadowing another.
extension SdContextV5X on BuildContext {
  ThemeData get theme5 => Theme.of(this);
  ColorScheme get colorScheme5 => theme5.colorScheme;
  TextTheme get textTheme5 => theme5.textTheme;

  bool get isDark5 => theme5.brightness == Brightness.dark;

  SdThemeV5 get sdTheme5 {
    final SdThemeV5? extension = theme5.extension<SdThemeV5>();

    assert(
      extension != null,
      'SdThemeV5 is missing from ThemeData.extensions. Register it in the '
      "app's theme so System Design v5 widgets can resolve their colours.",
    );

    return extension ?? SdThemeV5.fallback;
  }
}
