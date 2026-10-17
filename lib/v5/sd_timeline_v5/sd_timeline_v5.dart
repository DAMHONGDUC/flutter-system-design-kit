import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// Where a step stands. A done step shows a check, the current one a ring
/// with a filled dot, an upcoming one an empty ring — three shapes, not three
/// colours.
enum SdTimelineStateV5 { done, current, upcoming }

/// One step of an [SdTimelineV5].
@immutable
class SdTimelineStepV5 {
  const SdTimelineStepV5({
    required this.title,
    required this.state,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;

  /// A timestamp at the far end.
  final String? trailing;
  final SdTimelineStateV5 state;
}

/// A vertical progress track — an order's journey from placed to delivered.
class SdTimelineV5 extends StatelessWidget {
  const SdTimelineV5({required this.steps, super.key});

  final List<SdTimelineStepV5> steps;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      for (final (int i, SdTimelineStepV5 step) in steps.indexed)
        _StepRow(
          step: step,
          isLast: i == steps.length - 1,
          nextDone:
              i < steps.length - 1 &&
              steps[i + 1].state != SdTimelineStateV5.upcoming,
        ),
    ],
  );
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.step,
    required this.isLast,
    required this.nextDone,
  });

  final SdTimelineStepV5 step;
  final bool isLast;
  final bool nextDone;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Color faint = context.sdTheme5.border;
    final double dot = SdSpacingConstant.r24;
    final bool upcoming = step.state == SdTimelineStateV5.upcoming;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: dot,
            child: Column(
              children: <Widget>[
                Container(
                  width: dot,
                  height: dot,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.state == SdTimelineStateV5.done
                        ? ink
                        : context.sdTheme5.surface,
                    border: Border.all(color: upcoming ? faint : ink, width: 2),
                  ),
                  child: Center(
                    child: switch (step.state) {
                      SdTimelineStateV5.done => SdIconV5(
                        Symbols.check_rounded,
                        size: dot * 0.6,
                        color: context.sdTheme5.background,
                      ),
                      SdTimelineStateV5.current => Container(
                        width: dot * 0.4,
                        height: dot * 0.4,
                        decoration: BoxDecoration(
                          color: ink,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SdTimelineStateV5.upcoming => const SizedBox.shrink(),
                    },
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: SdSpacingConstant.w2,
                      margin: EdgeInsets.symmetric(
                        vertical: SdSpacingConstant.h2,
                      ),
                      color: nextDone ? ink : faint,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: SdSpacingConstant.w14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : SdSpacingConstant.h22,
                top: SdSpacingConstant.h2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          step.title,
                          style: context.textTheme5.bodyLarge!.semiBold5
                              .copyWith(
                                color: upcoming
                                    ? context.sdTheme5.textTertiary
                                    : ink,
                              ),
                        ),
                        if (step.subtitle != null) ...<Widget>[
                          SizedBox(height: SdSpacingConstant.h2),
                          Text(
                            step.subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme5.bodySmall!.muted5(
                              context,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (step.trailing != null)
                    Text(
                      step.trailing!,
                      style: context.textTheme5.labelSmall!.faint5(context),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
