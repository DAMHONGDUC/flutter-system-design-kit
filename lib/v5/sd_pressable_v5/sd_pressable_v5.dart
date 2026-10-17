import 'package:flutter/material.dart';

import '../sd_motion_v5/sd_motion_v5.dart';

/// Makes anything tappable with the v5 press: the child settles to
/// [pressedScale] under the finger and springs back on release.
///
/// The whole child is the hit box, never just its ink — a product card is
/// tapped on its photo as often as on its title.
class SdPressableV5 extends StatefulWidget {
  const SdPressableV5({
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.pressedScale = defaultPressedScale,
    this.semanticLabel,
    super.key,
  });

  /// Enough to be felt on a card, never enough to look like it moved.
  static const double defaultPressedScale = 0.97;

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final String? semanticLabel;

  @override
  State<SdPressableV5> createState() => _SdPressableV5State();
}

class _SdPressableV5State extends State<SdPressableV5> {
  bool _down = false;

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  void _set(bool down) {
    if (!mounted || !_enabled || down == _down) return;
    setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: _enabled,
    label: widget.semanticLabel,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (TapDownDetails _) => _set(true),
      onTapUp: (TapUpDetails _) => _set(false),
      onTapCancel: () => _set(false),
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedScale(
        scale: _down ? widget.pressedScale : 1,
        duration: SdMotionV5.of(context, SdMotionV5.fast),
        curve: SdMotionV5.standard,
        child: widget.child,
      ),
    ),
  );
}
