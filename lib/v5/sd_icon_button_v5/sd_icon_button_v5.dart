import 'package:flutter/material.dart';
import '../index.dart';

class SdIconButtonV5 extends StatelessWidget {
  const SdIconButtonV5({
    super.key,
    this.onPressed,
    required this.icon,
    this.padding,
  });

  final void Function()? onPressed;
  final Widget icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final finalPadding = padding ?? EdgeInsets.all(SdSpacingV5.s6);

    return SdInkWellV5(
      contentPadding: finalPadding,
      onTap: onPressed,
      child: icon,
    );
  }
}
