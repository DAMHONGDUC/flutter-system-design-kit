import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../index.dart';

class SdNumberTextFieldV5 extends StatefulWidget {
  const SdNumberTextFieldV5({
    super.key,
    required this.controller,
    required this.title,
    this.focusNode,
    this.rightWidget,
    this.inputFormatters,
    this.allowClear = false,
    this.onChanged,
    this.hintText,
    this.limitValue,
    this.onlyInt = false,
    this.textColor,
    this.inputHintColor,
    this.activeBorderColor,
  });

  final TextEditingController controller;
  final String title;
  final FocusNode? focusNode;
  final Widget? rightWidget;
  final List<TextInputFormatter>? inputFormatters;
  final bool allowClear;
  final void Function(String)? onChanged;
  final String? hintText;
  final int? limitValue;
  final bool onlyInt;
  final Color? textColor;
  final Color? inputHintColor;
  final Color? activeBorderColor;

  @override
  State<SdNumberTextFieldV5> createState() => _SdNumberTextFieldV5State();
}

class _SdNumberTextFieldV5State extends State<SdNumberTextFieldV5> {
  bool _showError = false;
  late int _limitValue;

  @override
  void initState() {
    _limitValue = widget.limitValue ?? SdConstantsV5.limitAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: SdSpacingV5.s2),
          child: Text(
            widget.title,
            style: SdTextStyleV5.body10()
                .copyWith(color: widget.textColor)
                .wMedium(),
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 7,
              child: TextField(
                // hintText: widget.hintText,
                // hintTextColor: widget.inputHintColor ?? SdColorsV5.grey600,
                inputFormatters: [
                  ...?widget.inputFormatters,
                  if (widget.onlyInt) SdCurrencyFormatHelperV5.intFormatter(),
                  SdCurrencyFormatHelperV5.limitFormatter(
                    limit: _limitValue,
                    currentErrorState: _showError,
                    onErrorChanged: (showError) {
                      setState(() {
                        _showError = showError;
                      });
                    },
                  ),
                ],
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.number,
                onChanged: widget.onChanged,
                // trailing:
                //     widget.allowClear
                //         ? GestureDetector(
                //           child: SdIconV5(
                //             iconData: MoonIcons.controls_close_small_24_light,
                //             color: widget.inputHintColor,
                //           ),
                //           onTap: _onTapClear,
                //         )
                //         : null,
                style: SdTextStyleV5.body14(),
                // activeBorderColor: widget.activeBorderColor,
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s6),
            if (widget.rightWidget != null)
              Flexible(
                flex: 3,
                child: widget.rightWidget ?? const SizedBox.shrink(),
              ),
          ],
        ),
        if (_showError)
          Padding(
            padding: EdgeInsets.only(left: SdSpacingV5.s2, top: SdSpacingV5.s2),
            child: Text(
              'Max value is: ${SdCurrencyFormatHelperV5.formatCurrencyFromDouble(_limitValue.toDouble())}',
              style: SdTextStyleV5.body9().wColor(SdColorsV5.red),
            ),
          ),
        SdVerticalSpacingV5(value: SdSpacingV5.s8),
      ],
    );
  }
}
