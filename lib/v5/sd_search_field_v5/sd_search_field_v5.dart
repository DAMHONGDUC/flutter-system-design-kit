import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';

/// A pill search well.
///
/// Two modes, one look: with a [controller] it is a live field with a clear
/// button that fades in once there is something to clear; without one it is
/// a button dressed as a field ([onTap]) — the home screen's entry to search,
/// which must look exactly like the field it opens so the hand-off reads as
/// one control.
class SdSearchFieldV5 extends StatefulWidget {
  const SdSearchFieldV5({
    required this.hint,
    this.controller,
    this.clearTooltip,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.autofocus = false,
    this.trailing,
    this.focusNode,
    super.key,
  }) : assert(
         controller != null || onTap != null,
         'Pass a controller for a live field or onTap for an entry button.',
       );

  final String hint;
  final TextEditingController? controller;
  final String? clearTooltip;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool autofocus;
  final FocusNode? focusNode;

  /// A control at the far end of the well — a filter button.
  final Widget? trailing;

  static double get height => SdSpacingConstant.h48;

  @override
  State<SdSearchFieldV5> createState() => _SdSearchFieldV5State();
}

class _SdSearchFieldV5State extends State<SdSearchFieldV5> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onText);
  }

  @override
  void didUpdateWidget(SdSearchFieldV5 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onText);
      widget.controller?.addListener(_onText);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onText);
    super.dispose();
  }

  void _onText() => setState(() {});

  void _clear() {
    widget.controller!.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = context.textTheme5.bodyLarge!.copyWith(
      color: context.sdTheme5.textPrimary,
    );
    final bool hasText = widget.controller?.text.isNotEmpty ?? false;

    final Widget field = widget.controller == null
        ? Text(
            widget.hint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle.copyWith(color: context.sdTheme5.textPlaceholder),
          )
        : TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            textInputAction: TextInputAction.search,
            cursorColor: context.sdTheme5.textPrimary,
            style: textStyle,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
              hintText: widget.hint,
              hintStyle: textStyle.copyWith(
                color: context.sdTheme5.textPlaceholder,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          );

    final Widget well = Container(
      height: SdSearchFieldV5.height,
      padding: EdgeInsets.only(
        left: SdSpacingConstant.w16,
        right: widget.trailing == null
            ? SdSpacingConstant.w8
            : SdSpacingConstant.w4,
      ),
      decoration: BoxDecoration(
        color: context.sdTheme5.surfaceSunken,
        borderRadius: SdRadiusV5.fullAll,
      ),
      child: Row(
        children: <Widget>[
          SdIconV5(
            Symbols.search_rounded,
            color: context.sdTheme5.textTertiary,
          ),
          SizedBox(width: SdSpacingConstant.w12),
          Expanded(child: field),
          if (widget.controller != null)
            AnimatedOpacity(
              opacity: hasText ? 1 : 0,
              duration: SdMotionV5.of(context, SdMotionV5.fast),
              child: IgnorePointer(
                ignoring: !hasText,
                child: IconButton(
                  tooltip: widget.clearTooltip,
                  onPressed: _clear,
                  icon: SdIconV5(
                    Symbols.cancel_rounded,
                    size: SdIconV5.smallSize * 1.15,
                    fill: 1,
                    color: context.sdTheme5.textTertiary,
                  ),
                ),
              ),
            ),
          ?widget.trailing,
        ],
      ),
    );

    if (widget.controller != null) return well;

    return SdPressableV5(
      onTap: widget.onTap,
      pressedScale: 0.98,
      semanticLabel: widget.hint,
      child: well,
    );
  }
}
