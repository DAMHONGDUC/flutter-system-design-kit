import 'package:flutter/material.dart';

class SdKeyboardDismisserV5 extends StatelessWidget {
  final Widget child;

  const SdKeyboardDismisserV5({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
