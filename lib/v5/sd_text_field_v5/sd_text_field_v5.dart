import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// The app's one text field: a label above a sunken well that gains a frame
/// in the primary colour while focused and in the danger colour on error.
///
/// The label sits *above* the well rather than floating inside it, so a
/// filled form reads as a list of answers, not a list of half-hidden
/// questions.
class SdTextFieldV5 extends StatefulWidget {
  const SdTextFieldV5({
    required this.label,
    required this.controller,
    this.hint,
    this.errorText,
    this.helperText,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;

  @override
  State<SdTextFieldV5> createState() => _SdTextFieldV5State();
}

class _SdTextFieldV5State extends State<SdTextFieldV5> {
  FocusNode? _ownFocus;

  FocusNode get _focus => widget.focusNode ?? (_ownFocus ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(SdTextFieldV5 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownFocus)?.removeListener(_onFocus);
      _focus.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _ownFocus?.dispose();
    super.dispose();
  }

  void _onFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;
    final Color frame = hasError
        ? context.sdTheme5.danger
        : _focus.hasFocus
        ? context.sdTheme5.textPrimary
        : Colors.transparent;
    final String? note = widget.errorText ?? widget.helperText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          widget.label,
          style: context.textTheme5.labelLarge!.semiBold5.copyWith(
            color: context.sdTheme5.textPrimary,
          ),
        ),
        SizedBox(height: SdSpacingConstant.h8),
        AnimatedContainer(
          duration: SdMotionV5.of(context, SdMotionV5.fast),
          curve: SdMotionV5.standard,
          decoration: BoxDecoration(
            color: _focus.hasFocus
                ? context.sdTheme5.surface
                : context.sdTheme5.surfaceSunken,
            borderRadius: SdRadiusV5.inputAll,
            border: Border.all(color: frame, width: 1.4),
          ),
          child: Row(
            crossAxisAlignment: widget.maxLines > 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: SdSpacingConstant.w16,
                    top: widget.maxLines > 1 ? SdSpacingConstant.h14 : 0,
                  ),
                  child: SdIconV5(
                    widget.prefixIcon!,
                    color: _focus.hasFocus
                        ? context.sdTheme5.textPrimary
                        : context.sdTheme5.textTertiary,
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focus,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  textInputAction: widget.textInputAction,
                  textCapitalization: widget.textCapitalization,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  autofillHints: widget.autofillHints,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  cursorColor: context.sdTheme5.textPrimary,
                  style: context.textTheme5.bodyLarge!.copyWith(
                    color: context.sdTheme5.textPrimary,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: context.textTheme5.bodyLarge!.copyWith(
                      color: context.sdTheme5.textPlaceholder,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SdSpacingConstant.w12,
                      vertical: SdSpacingConstant.h16,
                    ),
                  ),
                ),
              ),
              if (widget.suffix != null)
                Padding(
                  padding: EdgeInsets.only(right: SdSpacingConstant.w4),
                  child: widget.suffix,
                ),
            ],
          ),
        ),
        AnimatedSize(
          duration: SdMotionV5.of(context, SdMotionV5.fast),
          curve: SdMotionV5.standard,
          alignment: Alignment.topLeft,
          child: note == null
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: EdgeInsets.only(
                    top: SdSpacingConstant.h6,
                    left: SdSpacingConstant.w4,
                  ),
                  child: Text(
                    note,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme5.bodySmall!.copyWith(
                      color: hasError
                          ? context.sdTheme5.danger
                          : context.sdTheme5.textTertiary,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
