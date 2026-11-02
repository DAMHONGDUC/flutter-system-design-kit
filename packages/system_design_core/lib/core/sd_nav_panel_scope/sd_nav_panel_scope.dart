import 'package:flutter/widgets.dart';

/// What a tablet nav panel publishes to the screen standing beside it.
///
/// The panel collapses to nothing, so something on screen has to be able to
/// bring it back. The panel says only *that* it is collapsed and *how* to
/// reopen it, and whichever chrome the screen is already wearing hosts the
/// control — each generation's `SdNavPanelToggle…collapsedOf`.
///
/// Wrap the panel's content column once. A route pushed on the root navigator
/// sits outside the scope and reads null, which is correct — there is no panel
/// beside it to reopen.
///
/// **It carries the state and the callback, never the widget.** The control
/// is a look, and a look that arrived through an inherited widget is one two
/// chromes could draw differently without either file saying so. That is also
/// why it lives in core: it has no look, and v2 and v3 had the same class
/// line for line (`SdNavPanelScopeV2` and `SdNavPanelScopeV3` now name it).
class SdNavPanelScope extends InheritedWidget {
  const SdNavPanelScope({
    required this.isExpanded,
    required this.onExpand,
    required this.expandLabel,
    required super.child,
    super.key,
  });

  final bool isExpanded;

  /// Reopens the panel. Only ever called while [isExpanded] is false.
  final VoidCallback onExpand;

  /// The reopen control's tooltip and semantics label, localized by the host.
  final String expandLabel;

  /// The panel beside [context], or null where there is none.
  static SdNavPanelScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SdNavPanelScope>();

  @override
  bool updateShouldNotify(SdNavPanelScope oldWidget) =>
      oldWidget.isExpanded != isExpanded ||
      oldWidget.expandLabel != expandLabel ||
      oldWidget.onExpand != onExpand;
}
