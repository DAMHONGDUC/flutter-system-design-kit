import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../core/sd_spacing_constant.dart';
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

class _SdBottomNavigationV3State extends State<SdBottomNavigationV3> {
  double _dragDistance = 0;

  /// A notifier rather than `setState`, so a flip rebuilds the bar and never
  /// the tab body.
  final ValueNotifier<bool> _barVisible = ValueNotifier<bool>(true);

  @override
  void didUpdateWidget(SdBottomNavigationV3 oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A new tab starts with its bar, whatever the last one's list did.
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _barVisible.value = true;
    }
  }

  @override
  void dispose() {
    _barVisible.dispose();
    super.dispose();
  }

  void _setBarVisible(bool visible) {
    final SchedulerBinding binding = SchedulerBinding.instance;

    // A metrics change can report mid-layout, where no listener may rebuild.
    if (binding.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      binding.addPostFrameCallback((_) {
        if (mounted) _barVisible.value = visible;
      });
    } else {
      _barVisible.value = visible;
    }
  }

  /// The tab's own list only: a horizontal strip or a nested scrollable is
  /// not a reason to move the bar.
  static bool _isMainList(ScrollMetrics metrics, int depth) =>
      depth == 0 && metrics.axis == Axis.vertical;

  bool _onUserScroll(UserScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    final bool? visible = switch (notification.direction) {
      ScrollDirection.reverse => false,
      ScrollDirection.forward => true,
      ScrollDirection.idle => metrics.extentBefore <= 0 ? true : null,
    };

    if (!_isMainList(metrics, notification.depth) || visible == null) {
      return false;
    }

    _setBarVisible(visible);

    return false;
  }

  bool _onMetrics(ScrollMetricsNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    if (!_isMainList(metrics, notification.depth)) return false;

    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      _setBarVisible(true);
    }

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
  Widget build(BuildContext context) {
    final Duration duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : SdMotionV3.normal;

    return SdScaffoldV3(
      extendBody: true,
      body: SdFloatingBarScopeV3(
        edge: SdFloatingBarEdgeV3.bottom,
        child: NotificationListener<ScrollMetricsNotification>(
          onNotification: _onMetrics,
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onUserScroll,
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
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _barVisible,
        // The fade takes the shadow too, which a slide alone leaves peeking
        // over the bottom edge.
        builder: (BuildContext context, bool visible, Widget? bar) =>
            AnimatedSlide(
              offset: visible ? Offset.zero : const Offset(0, 1),
              duration: duration,
              curve: visible ? SdMotionV3.standard : SdMotionV3.exit,
              child: AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: duration,
                curve: visible ? SdMotionV3.standard : SdMotionV3.exit,
                child: bar,
              ),
            ),
        child: SdGlassNavBarV3(
          destinations: widget.destinations,
          selectedIndex: widget.selectedIndex,
          onSelected: widget.onSelected,
        ),
      ),
    );
  }
}
