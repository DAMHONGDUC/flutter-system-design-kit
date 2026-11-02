/// The shared app infrastructure in this package — **pure Dart, no Flutter**.
///
/// ```dart
/// import 'package:system_design_core/common.dart';
/// ```
///
/// A second entrypoint next to `core.dart` on purpose. `core.dart` exports
/// widgets, so importing it from a feature's `domain/` would drag Flutter
/// into a layer that is meant to stay pure Dart. This one never will —
/// nothing exported here may import `package:flutter/*`.
///
/// `core.dart` re-exports this file, so a widget that already imports the
/// package index gets [SdLogger] without a second import.
library;

export 'core/common/sd_crash_reporter.dart';
export 'core/common/sd_device_wipe.dart';
export 'core/common/sd_fresh_install.dart';
export 'core/common/sd_id.dart';
export 'core/common/sd_logger.dart';
