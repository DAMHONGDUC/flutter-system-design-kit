/// System Design core — what every widget generation shares: raw dimensions,
/// startup, breakpoints, screen scale, spacing, and the pure-Dart common
/// layer (logger, ids, crash reporter).
///
/// ```dart
/// import 'package:system_design_core/core.dart';
/// ```
///
/// Each generation's entry point (`v3.dart`, …) re-exports this file, so an
/// app imports its generation alone. A `domain/` layer that must stay pure
/// Dart imports `common.dart` instead.
library;

export 'common.dart';
export 'core/sd_bootstrap/sd_bootstrap.dart';
export 'core/sd_breakpoint.dart';
export 'core/sd_dev_wrapper/sd_dev_wrapper.dart';
export 'core/sd_screen_scale.dart';
export 'core/sd_spacing_constant.dart';
export 'utils/text_ext.dart';
