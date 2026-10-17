import 'package:flutter/material.dart';
import '../index.dart';

class SdHorizontalSpacingV5 extends StatelessWidget {
  const SdHorizontalSpacingV5({super.key, this.value, this.xRatio = 1});
  final double? value;
  final double xRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: (value ?? SdSpacingV5.s12) * xRatio);
  }
}
