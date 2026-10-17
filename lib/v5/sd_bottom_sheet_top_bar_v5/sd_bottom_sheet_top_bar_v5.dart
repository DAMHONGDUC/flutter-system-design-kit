import 'package:flutter/material.dart';

import '../index.dart';

class SdBottomSheetTopBarV5 extends StatelessWidget {
  final String? title;
  final Color? textColor;
  const SdBottomSheetTopBarV5({super.key, this.title, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SdVerticalSpacingV5(),
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SdVerticalSpacingV5(),
        if (title != null)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
              child: Text(
                title!,
                style: SdTextStyleV5.heading14().copyWith(color: textColor),
              ),
            ),
          ),
      ],
    );
  }
}
