import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';

/// A checkbox with its label; the whole row is the hit box.
class SdCheckboxV5 extends StatelessWidget {
  const SdCheckboxV5({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Duration duration = SdMotionV5.of(context, SdMotionV5.fast);

    return Semantics(
      checked: value,
      label: label,
      excludeSemantics: true,
      child: SdPressableV5(
        onTap: () => onChanged(!value),
        pressedScale: 0.98,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              duration: duration,
              width: SdSpacingConstant.r20,
              height: SdSpacingConstant.r20,
              decoration: BoxDecoration(
                color: value ? ink : Colors.transparent,
                borderRadius: BorderRadius.circular(SdSpacingConstant.r6),
                border: Border.all(
                  color: value ? ink : context.sdTheme5.border,
                  width: 1.6,
                ),
              ),
              child: AnimatedScale(
                scale: value ? 1 : 0,
                duration: duration,
                curve: SdMotionV5.pop,
                child: SdIconV5(
                  Symbols.check_rounded,
                  size: SdSpacingConstant.r16,
                  color: context.sdTheme5.background,
                ),
              ),
            ),
            SizedBox(width: SdSpacingConstant.w8),
            Flexible(
              child: Text(
                label,
                style: context.textTheme5.bodyMedium!.copyWith(color: ink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
