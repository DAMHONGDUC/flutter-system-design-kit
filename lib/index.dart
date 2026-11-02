/// System Design — the one import for everything in this package.
///
/// ```dart
/// import 'package:system_design/index.dart';
/// ```
///
/// **Prefer a generation package.** `package:system_design_v3/v3.dart` (and
/// v2, v4, v5) carries core and that generation only, with only its own
/// dependencies; this umbrella drags in every generation's — v5's video
/// plugins included. It stays for apps that have not moved yet.
///
/// `core/` holds what does not belong to a widget generation: raw dimensions
/// that any version of the system measures in. `v2/` and `v3/` are the widget
/// generations, and each owns everything about its own look.
///
/// **Both ship at once, and neither imports the other.** BaroEase renders on
/// v2; Reseller Studio renders on v3. An app that wanted to move between them could
/// do it widget by widget, because every name is suffixed with its
/// generation — `SdButtonV2` and `SdButtonV3` can sit in one file, and the
/// two `BuildContext` extensions do not collide (`context.sdTheme` is v2's,
/// `context.sdTheme3` is v3's).
///
/// A widget added to one generation is never "ported" to the other by import.
/// v2 is frozen for v3 work: it is what a shipped app is rendering, and a
/// change made to suit a different product is a change made to an app nobody
/// asked to redesign.
///
/// v5 is Tuku Shop's alone: the `system_design_flutter` package ported here,
/// router, bloc observer and media helpers included.
library;

export 'package:system_design_core/core.dart';
export 'package:system_design_v2/v2.dart';
export 'package:system_design_v3/v3.dart';
export 'package:system_design_v4/v4.dart';
export 'package:system_design_v5/v5.dart';
