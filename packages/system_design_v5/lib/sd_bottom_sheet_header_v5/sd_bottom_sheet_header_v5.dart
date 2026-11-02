import 'package:flutter/material.dart';

class SdBottomSheetHeaderV5 extends StatelessWidget {
  final String title;
  final VoidCallback? onOkPress;
  final VoidCallback? actionBeforeCancel;
  final String okeTitle;

  const SdBottomSheetHeaderV5({
    super.key,
    required this.title,
    this.onOkPress,
    this.actionBeforeCancel,
    this.okeTitle = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (actionBeforeCancel != null) {
              actionBeforeCancel!();
            }

            Navigator.pop(context);
          },
        ),
        Expanded(child: Text(title, textAlign: TextAlign.center)),
        TextButton(
          onPressed: () {
            if (onOkPress != null) {
              onOkPress!();
            }

            Navigator.pop(context);
          },
          child: Text(okeTitle),
        ),
      ],
    );
  }
}
