import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import '../sd_colors_v5/sd_colors_v5.dart';
import '../sd_spacing_v5/sd_spacing_v5.dart';

class SdSkeletonV5 extends StatelessWidget {
  final double? width;
  final double height;
  final double? borderRadiusValue;
  final Widget? customChild;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  const SdSkeletonV5({
    super.key,
    this.width,
    this.height = SdSpacingV5.s14,
    this.borderRadiusValue,
    this.customChild,
    this.borderRadius,
    this.color,
  });

  /// Helper: tạo ra shimmer gradient từ 1 màu gốc
  LinearGradient _buildShimmerGradient(Color baseColor) {
    final Color lighter = _lighten(baseColor, 0.15);
    final Color darker = _darken(baseColor, 0.1);

    return LinearGradient(
      colors: [darker, lighter, darker],
      stops: const [0.1, 0.5, 0.9],
    );
  }

  Color _lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? SdColorsV5.grey50;

    return SkeletonTheme(
      shimmerGradient: _buildShimmerGradient(baseColor),
      darkShimmerGradient: _buildShimmerGradient(baseColor),
      child: Skeleton(
        isLoading: true,
        skeleton: SkeletonItem(
          child:
              customChild ??
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius:
                      borderRadius ??
                      BorderRadius.circular(
                        borderRadiusValue ?? SdSpacingV5.s12,
                      ),
                ),
              ),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
