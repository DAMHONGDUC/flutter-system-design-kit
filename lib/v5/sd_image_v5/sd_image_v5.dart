import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';

/// A photo on the v5 backdrop, faded in on its first frame.
///
/// The app passes an [ImageProvider], so this neither knows nor cares whether
/// the picture ships in the bundle or comes over the network. A photo that
/// fails to load leaves the backdrop and a quiet glyph rather than the
/// framework's red error box.
class SdImageV5 extends StatelessWidget {
  const SdImageV5({
    required this.image,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.alignment = Alignment.center,
    this.semanticLabel,
    this.backdrop,
    super.key,
  });

  final ImageProvider image;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Alignment alignment;
  final String? semanticLabel;

  /// Defaults to `SdThemeV5.photoBackdrop`.
  final Color? backdrop;

  @override
  Widget build(BuildContext context) {
    final Widget picture = DecoratedBox(
      decoration: BoxDecoration(
        color: backdrop ?? context.sdTheme5.photoBackdrop,
      ),
      child: Image(
        image: image,
        fit: fit,
        alignment: alignment,
        width: double.infinity,
        height: double.infinity,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        gaplessPlayback: true,
        frameBuilder:
            (
              BuildContext context,
              Widget child,
              int? frame,
              bool wasSynchronouslyLoaded,
            ) {
              if (wasSynchronouslyLoaded) return child;

              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: SdMotionV5.of(context, SdMotionV5.slow),
                curve: SdMotionV5.standard,
                child: child,
              );
            },
        errorBuilder: (BuildContext context, Object error, StackTrace? _) =>
            Center(
              child: SdIconV5(
                Icons.image_not_supported_outlined,
                color: context.sdTheme5.textPlaceholder,
              ),
            ),
      ),
    );

    if (borderRadius == null) return picture;

    return ClipRRect(borderRadius: borderRadius!, child: picture);
  }
}
