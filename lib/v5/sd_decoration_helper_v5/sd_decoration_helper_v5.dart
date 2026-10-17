import 'package:flutter/material.dart';
import '../index.dart';

class SdDecorationHelperV5 {
  static InputDecoration textFieldDecoration(
    BuildContext context, {
    Color fillInputDefault = SdColorsV5.white,
    Color borderInputDefault = SdColorsV5.black,
  }) => InputDecoration(
    filled: true,
    fillColor: fillInputDefault,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      borderSide: BorderSide(width: 1, color: borderInputDefault),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      borderSide: BorderSide(width: 1, color: borderInputDefault),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      borderSide: BorderSide(width: 1, color: borderInputDefault),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      borderSide: BorderSide(width: 1, color: borderInputDefault),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
      borderSide: BorderSide(width: 1, color: borderInputDefault),
    ),
  );

  static BoxShadow boxShadow({int ratio = 1, required Color color}) {
    return BoxShadow(
      color: color,
      spreadRadius: 2.0 * ratio,
      blurRadius: 5.0 * ratio,
    );
  }
}
