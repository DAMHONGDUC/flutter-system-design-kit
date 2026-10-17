import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_motion_v5/sd_motion_v5.dart';

/// Rises its child into place: a fade and a short slide up, after
/// `SdMotionV5.staggerDelay(index)`.
///
/// Wrap the items of a list or grid with their index and they arrive one
/// after another rather than all at once. Runs once per mount — an item
/// scrolled back into a lazy list arrives again, which is the point: the
/// grid always reads as assembled, never as popped in.
class SdFadeInV5 extends StatefulWidget {
  const SdFadeInV5({
    required this.child,
    this.index = 0,
    this.offset,
    this.duration = SdMotionV5.slow,
    super.key,
  });

  final Widget child;
  final int index;

  /// How far below its place the child starts. Defaults to a 16 slide.
  final double? offset;
  final Duration duration;

  @override
  State<SdFadeInV5> createState() => _SdFadeInV5State();
}

class _SdFadeInV5State extends State<SdFadeInV5>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _t = CurvedAnimation(
    parent: _controller,
    curve: SdMotionV5.standard,
  );
  Timer? _delay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_controller.isAnimating || _controller.isCompleted || _delay != null) {
      return;
    }

    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      return;
    }

    _delay = Timer(SdMotionV5.staggerDelay(widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double distance = widget.offset ?? SdSpacingConstant.h16;

    return AnimatedBuilder(
      animation: _t,
      child: widget.child,
      builder: (BuildContext context, Widget? child) => Opacity(
        opacity: _t.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _t.value) * distance),
          child: child,
        ),
      ),
    );
  }
}
