import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';

/// Sweeps one highlight band across every [SdSkeletonV5] below it.
///
/// One controller per loading region rather than one per block: a grid of
/// twelve placeholder cards shimmers as one surface, in step, instead of
/// twelve bands drifting apart. It is the one loop v5 allows, and it stops —
/// leaving still blocks — when the OS asks for reduced motion.
class SdShimmerV5 extends StatefulWidget {
  const SdShimmerV5({required this.child, super.key});

  final Widget child;

  @override
  State<SdShimmerV5> createState() => _SdShimmerV5State();
}

class _SdShimmerV5State extends State<SdShimmerV5>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SdMotionV5.skeletonPass,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color base = context.sdTheme5.skeletonBase;
    final Color highlight = context.sdTheme5.skeletonHighlight;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value * 3 - 1;

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) => LinearGradient(
            begin: Alignment(t - 1, -0.3),
            end: Alignment(t + 1, 0.3),
            colors: <Color>[base, highlight, base],
            stops: const <double>[0.35, 0.5, 0.65],
          ).createShader(bounds),
          child: child,
        );
      },
    );
  }
}
