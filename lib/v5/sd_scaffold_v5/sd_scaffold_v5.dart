import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';

/// A [Scaffold] on the v5 page colour. The one place a screen's background
/// is decided, so no screen paints its own.
class SdScaffoldV5 extends StatelessWidget {
  const SdScaffoldV5({
    required this.body,
    this.appBar,
    this.bottomBar,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;

  /// A pinned action bar — "Add to bag", "Checkout".
  final Widget? bottomBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor ?? context.sdTheme5.background,
    appBar: appBar,
    body: body,
    bottomNavigationBar: bottomBar,
    extendBody: extendBody,
    extendBodyBehindAppBar: extendBodyBehindAppBar,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
  );
}
