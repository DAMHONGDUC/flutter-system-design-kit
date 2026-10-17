import 'package:flutter/material.dart';

class SdColorHelperV5 {
  static Color getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.replaceAll('#', '');

      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }

      return Color(int.parse(hexColor, radix: 16));
    } catch (err) {
      return Colors.black;
    }
  }

  static Color getContrastColor(Color background, {double threshold = 0.5}) {
    // Flutter's computeLuminance gives a perceptual brightness (0.0 - 1.0)
    final luminance = background.computeLuminance();
    return luminance > threshold ? Colors.black : Colors.white;
  }
}
