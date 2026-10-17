import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// HH : MM : SS in ink tiles, for a flash sale. Display only — the app owns
/// the clock and rebuilds this with the time left; each figure that changes
/// rolls in from below.
class SdCountdownV5 extends StatelessWidget {
  const SdCountdownV5({
    required this.remaining,
    required this.semanticLabel,
    super.key,
  });

  final Duration remaining;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Duration left = remaining.isNegative ? Duration.zero : remaining;
    final List<int> parts = <int>[
      left.inHours.clamp(0, 99),
      left.inMinutes % 60,
      left.inSeconds % 60,
    ];

    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final (int i, int part) in parts.indexed) ...<Widget>[
            if (i > 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w2),
                child: Text(
                  ':',
                  style: context.textTheme5.labelLarge!.bold5.copyWith(
                    color: context.sdTheme5.accent,
                  ),
                ),
              ),
            _Tile(value: part),
          ],
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) => Container(
    width: SdSpacingConstant.r28,
    height: SdSpacingConstant.r24,
    decoration: BoxDecoration(
      color: context.sdTheme5.accent,
      borderRadius: BorderRadius.circular(SdRadiusV5.skeleton * 0.75),
    ),
    clipBehavior: Clip.antiAlias,
    alignment: Alignment.center,
    child: AnimatedSwitcher(
      duration: SdMotionV5.of(context, SdMotionV5.fast),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.7),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
      child: Text(
        value.toString().padLeft(2, '0'),
        key: ValueKey<int>(value),
        style: context.textTheme5.labelLarge!.bold5.tabular5.copyWith(
          color: context.sdTheme5.onAccent,
        ),
      ),
    ),
  );
}
