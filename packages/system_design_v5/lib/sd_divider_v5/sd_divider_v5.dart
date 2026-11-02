import 'package:flutter/material.dart';
import '../sd_colors_v5/sd_colors_v5.dart';

class SdDividerV5 extends StatelessWidget {
  const SdDividerV5({
    super.key,
    this.color,
    this.thickness,
    this.height,
    this.indent,
    this.endIndent,
  });

  final Color? color;
  final double? thickness;

  /// The space the line takes up and sits centred in; defaults to the line itself.
  final double? height;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? SdColorsV5.grey100,
      thickness: thickness ?? 1,
      height: height ?? 1,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }
}
