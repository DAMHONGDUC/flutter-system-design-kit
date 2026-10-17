import 'package:flutter/material.dart';

import '../../utils/text_ext.dart';
import '../index.dart';

class SdTextFieldV5 extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String? hint;
  final VoidCallback? onTap;
  final Widget? rightWidget;
  final bool readOnly;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? activeBorderColor;

  const SdTextFieldV5({
    required this.controller,
    this.title,
    this.hint,
    this.onTap,
    this.rightWidget,
    this.readOnly = false,
    this.textStyle,
    this.textColor,
    this.activeBorderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotNullAndNotEmpty) ...[
          Text(
            title!,
            style: SdTextStyleV5.body10().copyWith(color: textColor).wMedium(),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s4),
        ],
        TextField(
          controller: controller,
          cursorColor: SdColorsV5.grey,
          readOnly: readOnly,
          // trailing: rightWidget,
          onTap: readOnly
              ? () {
                  FocusScope.of(context).unfocus();
                  onTap?.call();
                }
              : null,
          style: textStyle ?? SdTextStyleV5.body12(),
          // activeBorderColor: activeBorderColor,
        ),
      ],
    );
  }
}
