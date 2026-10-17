import 'package:flutter/material.dart';
import '../index.dart';

class SdInkWellV5 extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final double? borderRadius;
  final Color? containerBg;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final double? height;
  final Border? border;

  const SdInkWellV5({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = 100,
    this.containerBg,
    this.contentPadding,
    this.width,
    this.height,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderRadius = borderRadius ?? SdSpacingV5.s100;
    final defautPadding = contentPadding ?? EdgeInsets.all(SdSpacingV5.s12);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        color: containerBg,
        border: border,
      ),
      child: Material(
        color: SdColorsV5.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultBorderRadius),
            ),
          ),
          onTap: onTap,
          child: Container(padding: defautPadding, child: child),
        ),
      ),
    );
  }
}
