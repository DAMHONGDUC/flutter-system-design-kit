import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v2/sd_context_v2.dart';
import '../sd_text_style_v2/sd_text_style_v2.dart';

/// One axis of a multi-axis filter sheet: the axis' name, then every value it
/// offers as a wrap of single-choice chips, [selected] highlighted.
///
/// A tap only reports the value — the sheet holding several of these keeps
/// the draft and commits it from its own button, so moving a highlight here
/// never narrows a list behind the sheet. Separating sections is the sheet's
/// job too (`SdDividerV2` between them).
///
/// Chips, not the radio list `showSdFilterSheetV2` draws: a radio list is one
/// row per value, and a dozen axes of it is a sheet to scroll rather than one
/// to read.
class SdFilterSectionV2<T> extends StatelessWidget {
  const SdFilterSectionV2({
    required this.title,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
    super.key,
  });

  /// Already-localized axis name.
  final String title;

  final List<T> options;
  final T selected;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: context.textTheme.titleSmall!),
        SizedBox(height: SdSpacingConstant.h12),
        Wrap(
          spacing: SdSpacingConstant.w8,
          runSpacing: SdSpacingConstant.h8,
          children: <Widget>[
            for (final T option in options)
              _OptionChip(
                label: labelBuilder(option),
                selected: option == selected,
                onTap: () => onSelected(option),
              ),
          ],
        ),
      ],
    );
  }
}

/// One value of the axis. Selected wears `SdFilterPillV2`'s active look, so
/// "this is on" reads the same in the strip and in the sheet.
class _OptionChip extends StatelessWidget {
  const _OptionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  /// Matches `SdFilterPillV2`'s active fill.
  static const double _selectedFillOpacity = 0.16;

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final BorderRadius radius = BorderRadius.circular(SdSpacingConstant.r20);

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: selected
            ? scheme.primary.withValues(alpha: _selectedFillOpacity)
            : scheme.surfaceContainerHigh,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              // Transparent at rest keeps both states the same size.
              border: Border.all(
                color: selected ? scheme.primary : Colors.transparent,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SdSpacingConstant.w14,
              vertical: SdSpacingConstant.h8,
            ),
            child: Text(
              label,
              style: selected
                  ? context.textTheme.labelLarge!.semiBold.copyWith(
                      color: scheme.primary,
                    )
                  : context.textTheme.labelLarge!,
            ),
          ),
        ),
      ),
    );
  }
}
