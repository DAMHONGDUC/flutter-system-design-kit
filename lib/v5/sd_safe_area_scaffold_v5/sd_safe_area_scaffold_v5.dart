import 'package:flutter/material.dart';

import '../sd_adaptive_status_bar_v5/sd_adaptive_status_bar_v5.dart';
import '../sd_colors_v5/sd_colors_v5.dart';

class SdSafeAreaScaffoldV5 extends StatelessWidget {
  const SdSafeAreaScaffoldV5({
    super.key,
    this.backgroundColor,
    this.contentBgColor,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.persistentFooterButtons,
    this.onDrawerChanged,
    this.onEndDrawerChanged,

    // SafeArea specific parameters
    this.maintainBottomViewPadding = false,
    this.minimum = EdgeInsets.zero,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    required this.child,
  });

  // Scaffold parameters
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final List<Widget>? persistentFooterButtons;
  final DrawerCallback? onDrawerChanged;
  final DrawerCallback? onEndDrawerChanged;

  // SafeArea parameters
  final bool maintainBottomViewPadding;
  final EdgeInsets minimum;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  // Content parameters
  final Color? contentBgColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final finalBgColor = backgroundColor ?? SdColorsV5.white;
    final finalContentBgColor = contentBgColor ?? SdColorsV5.white;

    return SdAdaptiveStatusBarV5(
      backgroundColor: finalBgColor,
      child: Scaffold(
        key: key,
        backgroundColor: finalBgColor,
        appBar: appBar,
        body: SafeArea(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          minimum: minimum,
          maintainBottomViewPadding: maintainBottomViewPadding,
          child: ColoredBox(color: finalContentBgColor, child: child),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomSheet: bottomSheet,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        persistentFooterButtons: persistentFooterButtons,
        onDrawerChanged: onDrawerChanged,
        onEndDrawerChanged: onEndDrawerChanged,
      ),
    );
  }
}
