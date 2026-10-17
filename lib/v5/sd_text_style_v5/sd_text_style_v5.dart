import 'package:flutter/material.dart';
import '../index.dart';

abstract class SdBaseTextStyleV5 {
  static TextStyle base({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 10,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? SdColorsV5.black,
    );
  }
}

class SdTextStyleV5 extends SdBaseTextStyleV5 {
  SdTextStyleV5._();

  // Body styles (regular weight)
  static TextStyle body6() => SdBaseTextStyleV5.base().wSize(6);
  static TextStyle body8() => SdBaseTextStyleV5.base().wSize(8);
  static TextStyle body9() => SdBaseTextStyleV5.base().wSize(9);
  static TextStyle body10() => SdBaseTextStyleV5.base().wSize(10);
  static TextStyle body12() => SdBaseTextStyleV5.base().wSize(12);
  static TextStyle body14() => SdBaseTextStyleV5.base().wSize(14);
  static TextStyle body16() => SdBaseTextStyleV5.base().wSize(16);
  static TextStyle body18() => SdBaseTextStyleV5.base().wSize(18);
  static TextStyle body20() => SdBaseTextStyleV5.base().wSize(20);
  static TextStyle body24() => SdBaseTextStyleV5.base().wSize(24);
  static TextStyle body32() => SdBaseTextStyleV5.base().wSize(32);
  static TextStyle body40() => SdBaseTextStyleV5.base().wSize(40);
  static TextStyle body48() => SdBaseTextStyleV5.base().wSize(48);
  static TextStyle body56() => SdBaseTextStyleV5.base().wSize(56);
  static TextStyle body64() => SdBaseTextStyleV5.base().wSize(64);
  static TextStyle body72() => SdBaseTextStyleV5.base().wSize(72);

  // Heading styles (semi-bold)
  static TextStyle heading6() => SdBaseTextStyleV5.base().wSemiBold().wSize(6);
  static TextStyle heading8() => SdBaseTextStyleV5.base().wSemiBold().wSize(8);
  static TextStyle heading9() => SdBaseTextStyleV5.base().wSemiBold().wSize(9);
  static TextStyle heading10() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(10);
  static TextStyle heading12() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(12);
  static TextStyle heading13() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(13);
  static TextStyle heading14() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(14);
  static TextStyle heading16() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(16);
  static TextStyle heading18() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(18);
  static TextStyle heading20() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(20);
  static TextStyle heading24() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(24);
  static TextStyle heading28() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(28);
  static TextStyle heading32() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(32);
  static TextStyle heading40() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(40);
  static TextStyle heading48() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(48);
  static TextStyle heading56() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(56);
  static TextStyle heading64() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(64);
  static TextStyle heading72() =>
      SdBaseTextStyleV5.base().wSemiBold().wSize(72);
}

extension SdTextStyleV5X on TextStyle {
  TextStyle wLight() => copyWith(fontWeight: FontWeight.w300);
  TextStyle wRegular() => copyWith(fontWeight: FontWeight.w400);
  TextStyle wMedium() => copyWith(fontWeight: FontWeight.w500);
  TextStyle wSemiBold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle wBold() => copyWith(fontWeight: FontWeight.w700);
  TextStyle wColor(Color color) => copyWith(color: color);
  TextStyle wSize(double fontSize) => copyWith(fontSize: fontSize);
  TextStyle wFontFamily(String fontFamily) => copyWith(fontFamily: fontFamily);
  TextStyle wItalic() => copyWith(fontStyle: FontStyle.italic);
  TextStyle whiteText() => copyWith(color: SdColorsV5.white);
}
