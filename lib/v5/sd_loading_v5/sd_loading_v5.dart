import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';

/// A small spinner, for a "load more" row at the end of a list. A screen's
/// first load uses skeletons instead.
class SdLoadingV5 extends StatelessWidget {
  const SdLoadingV5({this.size, this.color, super.key});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox.square(
      dimension: size ?? SdSpacingConstant.r24,
      child: CircularProgressIndicator(
        strokeWidth: SdSpacingConstant.w2,
        strokeCap: StrokeCap.round,
        color: color ?? context.sdTheme5.textPrimary,
      ),
    ),
  );
}
