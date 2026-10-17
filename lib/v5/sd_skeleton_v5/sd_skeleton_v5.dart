import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';

/// A placeholder block. Always a rectangle at `SdRadiusV5.skeleton` — one
/// shape, so a loading screen reads as one loading state rather than a pile
/// of components impersonating content. Wrap a region in `SdShimmerV5` to
/// make it sweep.
class SdSkeletonV5 extends StatelessWidget {
  const SdSkeletonV5({this.width, this.height, super.key});

  /// Null fills the parent's constraint on that axis.
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => Container(
    width: width ?? double.infinity,
    height: height ?? double.infinity,
    decoration: BoxDecoration(
      color: context.sdTheme5.skeletonBase,
      borderRadius: SdRadiusV5.skeletonAll,
    ),
  );
}
