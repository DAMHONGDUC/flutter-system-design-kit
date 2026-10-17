import 'package:flutter/widgets.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';

/// The three shadows v5 draws, all from `SdThemeV5.shadow`. Soft and wide:
/// product cards float, they do not cast.
final class SdElevationV5 {
  static List<BoxShadow> low(BuildContext context) => <BoxShadow>[
    BoxShadow(
      color: context.sdTheme5.shadow,
      blurRadius: SdSpacingConstant.r12,
      offset: Offset(0, SdSpacingConstant.h4),
    ),
  ];

  static List<BoxShadow> medium(BuildContext context) => <BoxShadow>[
    BoxShadow(
      color: context.sdTheme5.shadow,
      blurRadius: SdSpacingConstant.r24,
      offset: Offset(0, SdSpacingConstant.h8),
    ),
  ];

  static List<BoxShadow> high(BuildContext context) => <BoxShadow>[
    BoxShadow(
      color: context.sdTheme5.shadow.withValues(
        alpha: context.sdTheme5.shadow.a * 1.6,
      ),
      blurRadius: SdSpacingConstant.r36,
      offset: Offset(0, SdSpacingConstant.h12),
    ),
  ];
}
