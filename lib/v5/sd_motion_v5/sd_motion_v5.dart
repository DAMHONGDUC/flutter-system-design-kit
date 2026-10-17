import 'package:flutter/widgets.dart';

/// Every duration and curve v5 animates with.
///
/// A storefront is allowed more movement than a ledger: product cards rise
/// into place, a heart pops, a page slides. It is still calm — nothing loops
/// except the skeleton, nothing is longer than [page], and
/// [of] collapses all of it to zero under the OS reduce-motion setting.
final class SdMotionV5 {
  static const Duration fast = Duration(milliseconds: 150);

  static const Duration normal = Duration(milliseconds: 260);

  static const Duration slow = Duration(milliseconds: 380);

  /// A route transition or a hero image settling.
  static const Duration page = Duration(milliseconds: 420);

  /// The gap between two items of a staggered entrance.
  static const Duration stagger = Duration(milliseconds: 55);

  /// The cap on a stagger, so item 40 of a grid does not arrive two seconds
  /// after item 1.
  static const int maxStaggerSteps = 8;

  static const Duration snackBar = Duration(milliseconds: 2800);

  static const Duration skeletonPass = Duration(milliseconds: 1400);

  static const Curve standard = Curves.easeOutCubic;

  static const Curve exit = Curves.easeInCubic;

  static const Curve emphasized = Curves.easeInOutCubic;

  /// A small overshoot for things that "land": a heart, a cart badge.
  static const Curve pop = Curves.easeOutBack;

  /// [duration], or zero when the user turned animations off.
  static Duration of(BuildContext context, Duration duration) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;

  /// The delay for item [index] of a staggered entrance.
  static Duration staggerDelay(int index) =>
      stagger * index.clamp(0, maxStaggerSteps);
}
