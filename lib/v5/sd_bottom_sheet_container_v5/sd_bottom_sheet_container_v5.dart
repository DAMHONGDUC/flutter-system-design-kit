import 'package:flutter/material.dart';
import '../index.dart';

class SdBottomSheetContainerV5 extends StatelessWidget {
  const SdBottomSheetContainerV5({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s12),
      color: SdColorsV5.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
