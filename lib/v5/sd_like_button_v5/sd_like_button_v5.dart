import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_elevation_v5/sd_elevation_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';

/// The wishlist heart. Filling it pops — a quick overshoot with a light
/// haptic — so saving an item feels like a decision, and un-saving it is
/// quiet. Outline vs filled carries the state, not the red alone.
class SdLikeButtonV5 extends StatefulWidget {
  const SdLikeButtonV5({
    required this.liked,
    required this.onChanged,
    required this.tooltip,
    this.size,
    this.floating = true,
    super.key,
  });

  final bool liked;
  final ValueChanged<bool> onChanged;
  final String tooltip;
  final double? size;

  /// A surface disc with a shadow, for a heart laid over a product photo.
  final bool floating;

  @override
  State<SdLikeButtonV5> createState() => _SdLikeButtonV5State();
}

class _SdLikeButtonV5State extends State<SdLikeButtonV5>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SdMotionV5.slow,
  );

  late final Animation<double> _scale = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 1.35),
        weight: 35,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.35, end: 0.92),
        weight: 30,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.92, end: 1),
        weight: 35,
      ),
    ],
  ).animate(CurvedAnimation(parent: _controller, curve: SdMotionV5.standard));

  @override
  void didUpdateWidget(SdLikeButtonV5 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.liked &&
        widget.liked &&
        !MediaQuery.disableAnimationsOf(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (!widget.liked) HapticFeedback.lightImpact();
    widget.onChanged(!widget.liked);
  }

  @override
  Widget build(BuildContext context) {
    final double diameter = widget.size ?? SdSpacingConstant.r36;

    return Tooltip(
      message: widget.tooltip,
      child: Semantics(
        button: true,
        toggled: widget.liked,
        label: widget.tooltip,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: Container(
            width: diameter,
            height: diameter,
            decoration: widget.floating
                ? BoxDecoration(
                    color: context.sdTheme5.surface,
                    shape: BoxShape.circle,
                    boxShadow: SdElevationV5.low(context),
                  )
                : null,
            child: Center(
              child: ScaleTransition(
                scale: _scale,
                child: SdIconV5(
                  Symbols.favorite_rounded,
                  size: diameter * 0.52,
                  fill: widget.liked ? 1 : 0,
                  color: widget.liked
                      ? context.sdTheme5.accent
                      : context.sdTheme5.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
