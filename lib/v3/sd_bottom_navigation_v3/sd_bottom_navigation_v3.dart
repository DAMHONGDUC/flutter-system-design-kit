import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v3/sd_content_padding_v3.dart';
import '../sd_floating_bar_scope_v3/sd_floating_bar_scope_v3.dart';
import '../sd_glass_nav_bar_v3/sd_glass_nav_bar_v3.dart';
import '../sd_motion_v3/sd_motion_v3.dart';
import '../sd_nav_cell_v3/sd_nav_cell_v3.dart';
import '../sd_scaffold_v3/sd_scaffold_v3.dart';

/// The complete frame for a glyph-only floating bottom navigation.
///
/// The host supplies destinations and changes its own selected content. This
/// widget owns the glass frame and adjacent-tab swipe so every app gets the
/// same interaction and clearance.
///
/// **It also owns whether the bar is on screen.** Scrolling a tab's main list
/// down slides the bar away and scrolling up brings it back, on every tab —
/// no screen opts in or out. The bar is translated, never removed from
/// layout, so the clearance under every list holds in both states.
///
/// **The bar follows the finger, then settles.** It moves by exactly as much
/// as the list did, so it can never run ahead of or lag the content; when the
/// scroll ends a half-hidden bar finishes in the direction the list last
/// moved. Finishing to the nearer end left it hidden after a short scroll
/// up — a seller asking for the tabs back and not getting them.
///
/// It always comes back without a scroll the seller has to invent: on a tab
/// change, at the top of the list, and the moment the list stops being
/// scrollable — a filter that empties it must not strand the seller.
class SdBottomNavigationV3 extends StatefulWidget {
  const SdBottomNavigationV3({
    required this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  }) : assert(destinations.length > 0),
       assert(selectedIndex >= 0 && selectedIndex < destinations.length);

  final Widget body;
  final List<SdNavDestinationV3> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// A deliberate swipe, large enough that a slightly diagonal vertical drag
  /// does not switch tabs after winning the horizontal gesture arena.
  static double get swipeDistance => SdSpacingConstant.w48;

  @visibleForTesting
  static const Key swipeSurfaceKey = Key('sd-bottom-navigation-swipe-surface');

  @override
  State<SdBottomNavigationV3> createState() => _SdBottomNavigationV3State();
}

class _SdBottomNavigationV3State extends State<SdBottomNavigationV3>
    with SingleTickerProviderStateMixin {
  double _dragDistance = 0;

  /// How hidden the bar is: 0 on screen, 1 fully below the window. Driven by
  /// the scroll directly and animated only to settle.
  late final AnimationController _hidden = AnimationController(vsync: this);

  /// The sign of the last in-range scroll: negative is up, towards the tabs.
  double _lastDelta = 0;

  @override
  void didUpdateWidget(SdBottomNavigationV3 oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A new tab starts with its bar, whatever the last one's list did.
    if (oldWidget.selectedIndex != widget.selectedIndex) _settle(0);
  }

  @override
  void dispose() {
    _hidden.dispose();
    super.dispose();
  }

  /// Animates the bar to fully shown (0) or fully hidden (1).
  void _settle(double target) {
    final Duration duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : SdMotionV3.normal;
    final SchedulerBinding binding = SchedulerBinding.instance;

    if (_hidden.value == target && !_hidden.isAnimating) return;

    // A metrics change can report mid-layout, where no listener may rebuild.
    if (binding.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      binding.addPostFrameCallback((_) {
        if (mounted) _settle(target);
      });
      return;
    }

    _hidden.animateTo(target, duration: duration, curve: SdMotionV3.standard);
  }

  /// The tab's own list only: a horizontal strip or a nested scrollable is
  /// not a reason to move the bar.
  static bool _isMainList(ScrollMetrics metrics, int depth) =>
      depth == 0 && metrics.axis == Axis.vertical;

  bool _onScroll(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    if (!_isMainList(metrics, notification.depth)) return false;

    if (notification is ScrollUpdateNotification) {
      _follow(metrics, notification.scrollDelta ?? 0);
    } else if (notification is ScrollEndNotification) {
      _settle(metrics.extentBefore <= 0 || _lastDelta < 0 ? 0 : 1);
    }

    return false;
  }

  /// Moves the bar by as much as the list moved, in the bar's own height.
  ///
  /// Past either end the finger still drives it — a short list runs out of
  /// scroll before the bar is gone, and stopping there left it stuck half
  /// way. Only the bounce settling back is ignored: that is the list, not the
  /// seller, and reading it as a scroll up brought the bar straight back.
  void _follow(ScrollMetrics metrics, double delta) {
    final double extent = SdContentPaddingV3.floatingBarInset(context);
    final double before = metrics.pixels - delta;
    final bool pastEnd =
        metrics.pixels > metrics.maxScrollExtent ||
        before > metrics.maxScrollExtent;
    final bool pastStart =
        metrics.pixels < metrics.minScrollExtent ||
        before < metrics.minScrollExtent;

    if (delta == 0 || (pastEnd && delta < 0) || (pastStart && delta > 0)) {
      return;
    }

    _lastDelta = delta;
    _hidden.stop();
    _hidden.value = (_hidden.value + delta / extent).clamp(0.0, 1.0);
  }

  bool _onMetrics(ScrollMetricsNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    if (!_isMainList(metrics, notification.depth)) return false;

    if (metrics.maxScrollExtent <= metrics.minScrollExtent) _settle(0);

    return false;
  }

  void _startSwipe(DragStartDetails _) => _dragDistance = 0;

  void _updateSwipe(DragUpdateDetails details) {
    _dragDistance += details.primaryDelta ?? 0;
  }

  void _cancelSwipe() => _dragDistance = 0;

  void _finishSwipe(DragEndDetails _) {
    final double distance = _dragDistance;
    _dragDistance = 0;

    if (distance.abs() < SdBottomNavigationV3.swipeDistance) return;

    final int direction = distance < 0 ? 1 : -1;
    final int nextIndex = widget.selectedIndex + direction;

    if (nextIndex < 0 || nextIndex >= widget.destinations.length) return;

    widget.onSelected(nextIndex);
  }

  @override
  Widget build(BuildContext context) => SdScaffoldV3(
    extendBody: true,
    body: SdFloatingBarScopeV3(
      edge: SdFloatingBarEdgeV3.bottom,
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: _onMetrics,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: GestureDetector(
            key: SdBottomNavigationV3.swipeSurfaceKey,
            behavior: HitTestBehavior.translucent,
            excludeFromSemantics: true,
            onHorizontalDragStart: _startSwipe,
            onHorizontalDragUpdate: _updateSwipe,
            onHorizontalDragCancel: _cancelSwipe,
            onHorizontalDragEnd: _finishSwipe,
            child: widget.body,
          ),
        ),
      ),
    ),
    // A translation only — no fade: an opacity layer over the glass forces
    // its refraction to re-render offscreen every frame of the slide.
    bottomNavigationBar: AnimatedBuilder(
      animation: _hidden,
      builder: (BuildContext context, Widget? bar) => FractionalTranslation(
        translation: Offset(0, _hidden.value),
        child: bar,
      ),
      child: SdGlassNavBarV3(
        destinations: widget.destinations,
        selectedIndex: widget.selectedIndex,
        onSelected: widget.onSelected,
      ),
    ),
  );
}
