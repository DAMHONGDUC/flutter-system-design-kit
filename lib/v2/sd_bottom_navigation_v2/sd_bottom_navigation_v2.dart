import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_breakpoint_v2/sd_breakpoint_v2.dart';
import '../sd_content_padding_v2/sd_content_padding_v2.dart';
import '../sd_context_v2/sd_context_v2.dart';
import '../sd_floating_bar_scope_v2/sd_floating_bar_scope_v2.dart';
import '../sd_liquid_glass_theme_v2/sd_liquid_glass_theme_v2.dart';
import '../sd_nav_destination_v2/sd_nav_destination_v2.dart';
import '../sd_nav_segment_v2/sd_nav_segment_v2.dart';
import '../sd_pop_scale_v2/sd_pop_scale_v2.dart';

part 'sd_bottom_navigation_v2_bar.dart';

/// The complete frame for a glyph-only floating bottom navigation.
///
/// The host supplies destinations and changes its own selected content. This
/// widget owns the glass pill, the sliding thumb and the adjacent-tab swipe,
/// so every screen behind it gets the same interaction and the same
/// clearance.
///
/// **A plain [Scaffold], not `SdScaffoldV2`** — the shell has no app bar of
/// its own; each tab screen brings its own `SdScaffoldV2` and its own title.
/// [Scaffold.extendBody] is unconditional here: the pill stays glass on every
/// engine (`SdGlassV2` degrades that one surface to `FakeGlass` by itself),
/// so its footprint is layout on every engine too. Screens behind it pad by
/// `SdContentPaddingV2.bottom(floatingNav: true)`.
///
/// **It also owns whether the bar is on screen.** Scrolling a tab's main list
/// down slides the pill away and scrolling up brings it back, on every tab —
/// no screen opts in or out. The pill is translated, never removed from
/// layout, so the clearance under every list holds in both states.
///
/// **The pill follows the finger, then settles.** It moves by exactly as much
/// as the list did; when the scroll ends a half-hidden pill finishes in the
/// direction the list last moved. It always comes back on its own on a tab
/// change, at the top of the list, and the moment the list stops being
/// scrollable — a list that empties must not strand the user without tabs.
class SdBottomNavigationV2 extends StatefulWidget {
  const SdBottomNavigationV2({
    required this.body,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  }) : assert(destinations.length > 0, 'A nav bar needs a destination.'),
       assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex is out of range for destinations.',
       );

  final Widget body;
  final List<SdNavDestinationV2> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// A deliberate swipe, large enough that a slightly diagonal vertical drag
  /// does not switch tabs after winning the horizontal gesture arena.
  static double get swipeDistance => SdSpacingConstant.w48;

  @visibleForTesting
  static const Key swipeSurfaceKey = Key('sd-bottom-navigation-v2-swipe');

  @override
  State<SdBottomNavigationV2> createState() => _SdBottomNavigationV2State();
}

class _SdBottomNavigationV2State extends State<SdBottomNavigationV2>
    with SingleTickerProviderStateMixin {
  /// Calm, and under the 400ms ceiling (WIDGET_RULES § 6).
  static const Duration _settleDuration = Duration(milliseconds: 250);

  double _dragDistance = 0;

  /// How hidden the pill is: 0 on screen, 1 fully below the window. Driven by
  /// the scroll directly and animated only to settle.
  late final AnimationController _hidden = AnimationController(vsync: this);

  /// The sign of the last in-range scroll: negative is up, towards the tabs.
  double _lastDelta = 0;

  @override
  void didUpdateWidget(SdBottomNavigationV2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A new tab starts with its pill, whatever the last one's list did.
    if (oldWidget.selectedIndex != widget.selectedIndex) _settle(0);
  }

  @override
  void dispose() {
    _hidden.dispose();
    super.dispose();
  }

  /// Animates the pill to fully shown (0) or fully hidden (1).
  void _settle(double target) {
    final Duration duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : _settleDuration;
    final SchedulerBinding binding = SchedulerBinding.instance;

    if (_hidden.value == target && !_hidden.isAnimating) return;

    // A metrics change can report mid-layout, where no listener may rebuild.
    if (binding.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      binding.addPostFrameCallback((_) {
        if (mounted) _settle(target);
      });
      return;
    }

    _hidden.animateTo(target, duration: duration, curve: Curves.easeOutCubic);
  }

  /// The tab's own list only: a horizontal strip or a nested scrollable is
  /// not a reason to move the pill.
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

  /// Moves the pill by as much as the list moved, in the pill's own height.
  ///
  /// Past either end the finger still drives it — a short list runs out of
  /// scroll before the pill is gone. Only the bounce settling back is
  /// ignored: that is the list, not the user, and reading it as a scroll up
  /// brought the pill straight back. A list that fits on screen moves
  /// nothing: its only motion is the rubber band.
  void _follow(ScrollMetrics metrics, double delta) {
    final double extent = SdContentPaddingV2.floatingBarInset(context);
    final double before = metrics.pixels - delta;
    final bool fits = metrics.maxScrollExtent <= metrics.minScrollExtent;
    final bool pastEnd =
        metrics.pixels > metrics.maxScrollExtent ||
        before > metrics.maxScrollExtent;
    final bool pastStart =
        metrics.pixels < metrics.minScrollExtent ||
        before < metrics.minScrollExtent;

    if (fits ||
        delta == 0 ||
        (pastEnd && delta < 0) ||
        (pastStart && delta > 0)) {
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

    if (distance.abs() < SdBottomNavigationV2.swipeDistance) return;

    // Dragging left (negative) walks forward through the tabs.
    final int direction = distance < 0 ? 1 : -1;
    final int nextIndex = widget.selectedIndex + direction;

    if (nextIndex < 0 || nextIndex >= widget.destinations.length) return;

    widget.onSelected(nextIndex);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // Lets the body flow behind the pill so it refracts through the glass.
    extendBody: true,
    // Tells anything drawn over the app — a snackbar goes into the root
    // overlay, above the shell — that the pill is down there to clear.
    body: SdFloatingBarScopeV2(
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: _onMetrics,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: GestureDetector(
            key: SdBottomNavigationV2.swipeSurfaceKey,
            // Translucent so a scrollable, a slider or a chart underneath
            // claims its own horizontal drag first; only the misses reach this.
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
      child: _GlassNavBar(
        destinations: widget.destinations,
        selectedIndex: widget.selectedIndex,
        onSelected: widget.onSelected,
      ),
    ),
  );
}
