import 'package:flutter/material.dart';

/// Custom scroll behavior that disables the default overscroll glow effect.
class _SdScrollBehaviorV5 extends ScrollBehavior {
  const _SdScrollBehaviorV5();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

/// Widget wrapper to apply no-glow scroll behavior to its child.
class SdScrollConfigV5 extends StatelessWidget {
  final Widget child;

  const SdScrollConfigV5({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const _SdScrollBehaviorV5(),
      child: child,
    );
  }
}
