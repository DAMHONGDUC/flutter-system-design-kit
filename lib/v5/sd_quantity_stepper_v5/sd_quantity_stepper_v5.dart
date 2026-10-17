import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// − value + in a pill. The figure slides in the direction it moved, so a
/// quantity going up is seen going up.
///
/// The bounds disable their own button rather than clamping silently: a
/// minus that does nothing at 1 looks broken, a disabled one explains itself.
class SdQuantityStepperV5 extends StatelessWidget {
  const SdQuantityStepperV5({
    required this.value,
    required this.onChanged,
    required this.decreaseTooltip,
    required this.increaseTooltip,
    this.min = 1,
    this.max = 99,
    this.compact = false,
    super.key,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final String decreaseTooltip;
  final String increaseTooltip;
  final int min;
  final int max;

  /// The smaller size used inside a bag row.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double cell = compact ? SdSpacingConstant.r32 : SdSpacingConstant.r40;

    return Container(
      decoration: BoxDecoration(
        color: context.sdTheme5.surfaceSunken,
        borderRadius: SdRadiusV5.fullAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _StepButton(
            icon: Symbols.remove_rounded,
            tooltip: decreaseTooltip,
            size: cell,
            onTap: value > min ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: cell * 0.9,
            child: AnimatedSwitcher(
              duration: SdMotionV5.of(context, SdMotionV5.fast),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.4),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
              child: Text(
                '$value',
                key: ValueKey<int>(value),
                textAlign: TextAlign.center,
                style:
                    (compact
                            ? context.textTheme5.labelLarge!
                            : context.textTheme5.titleMedium!)
                        .bold5
                        .tabular5
                        .copyWith(color: context.sdTheme5.textPrimary),
              ),
            ),
          ),
          _StepButton(
            icon: Symbols.add_rounded,
            tooltip: increaseTooltip,
            size: cell,
            onTap: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: SdPressableV5(
      onTap: onTap,
      pressedScale: 0.85,
      semanticLabel: tooltip,
      child: SizedBox.square(
        dimension: size,
        child: Center(
          child: SdIconV5(
            icon,
            size: size * 0.45,
            color: onTap == null
                ? context.sdTheme5.textPlaceholder
                : context.sdTheme5.textPrimary,
          ),
        ),
      ),
    ),
  );
}
