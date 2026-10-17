import 'package:flutter/widgets.dart';

/// Closes the keyboard on a tap anywhere outside a field. Wraps a form
/// screen; the tap still reaches whatever was under it.
class SdKeyboardDismissV5 extends StatelessWidget {
  const SdKeyboardDismissV5({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: child,
  );
}
