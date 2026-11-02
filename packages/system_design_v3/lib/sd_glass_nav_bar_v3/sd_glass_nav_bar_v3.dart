import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../sd_content_padding_v3/sd_content_padding_v3.dart';
import '../sd_context_v3/sd_context_v3.dart';
import '../sd_elevation_v3/sd_elevation_v3.dart';
import '../sd_motion_v3/sd_motion_v3.dart';
import '../sd_nav_cell_v3/sd_nav_cell_v3.dart';

/// A floating glass tab bar, in the iOS 26 idiom. **The phone's chrome.**
///
/// **The body scrolls behind it**, which is the whole point of the look and
/// the reason it is not a `Scaffold.bottomNavigationBar` in the ordinary
/// sense: it is handed to that slot, but the scaffold sets `extendBody` so
/// content passes underneath and refracts through the glass.
///
/// That makes the bar's geometry *layout*, not decoration — every screen
/// behind it has to clear its footprint. `SdContentPaddingV3.floatingBarInset`
/// is the one place that number lives, and tab screens pass
/// `floatingNav: true` to pick it up. Get this wrong and the last row of
/// every list hides behind the bar.
///
/// **Five equal segments, one glyph each, and no painted labels** — owner's
/// rule. The current tab is marked by its filled glyph and a tinted thumb that
/// slides inside the bar under its equal-width segment.
///
/// On anything wider than a phone the shell builds `SdNavigationRailV3`
/// instead. The two share [SdNavCellV3] and the glass, and differ only in the
/// axis they run along.
///
/// Degrades to a flat translucent fill where the shader cannot run — see
/// [SdGlassV3]. The geometry is identical either way, so nothing reflows.
class SdGlassNavBarV3 extends StatelessWidget {
  const SdGlassNavBarV3({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    this.movement,
    super.key,
  });

  final List<SdNavDestinationV3> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// Ticks on every frame the parent moves the bar on screen.
  ///
  /// **The glass caches its shape in screen space and notices a move only
  /// after the frame is drawn**, so a moving bar painted its shader over last
  /// frame's shape — a white strip along the leading edge, as tall as the
  /// move. Each tick relays the glass out, which rebuilds the shape in the
  /// frame that moved it. Null for a bar that never moves.
  final Listenable? movement;

  /// Test seam. The capsule's whole point is where it is and how wide it is
  /// mid-flight, and both are real layout — a test measures its rect rather
  /// than reading a widget's arguments back.
  @visibleForTesting
  static const Key selectedCapsuleKey = Key('sd-nav-selected-capsule');

  @override
  Widget build(BuildContext context) {
    final double inset = SdContentPaddingV3.navBarOffset(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SdContentPaddingV3.floatingBarHorizontal,
        0,
        SdContentPaddingV3.floatingBarHorizontal,
        inset,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SdContentPaddingV3.floatingBarRadius,
          ),
          boxShadow: SdElevationV3.modal(context),
        ),
        child: LiquidGlass.withOwnLayer(
          shape: LiquidRoundedSuperellipse(
            borderRadius: SdContentPaddingV3.floatingBarRadius,
          ),
          settings: SdGlassV3.settings(context),
          fake: !SdGlassV3.isSupported,
          glassContainsChild: false,
          child: _RelayoutOnTick(
            listenable: movement,
            child: SizedBox(
              height: SdContentPaddingV3.floatingBarHeight,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _SelectedCapsule(
                    count: destinations.length,
                    selectedIndex: selectedIndex,
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < destinations.length; i++)
                        Expanded(
                          child: SdNavCellV3(
                            destination: destinations[i],
                            selected: i == selectedIndex,
                            onTap: () => onSelected(i),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The tinted thumb that marks the current tab and slides to the next one.
///
/// **Always one segment wide.** This is an icon-only bar: a capsule that
/// widens has no label to make room for and reads as unrelated motion.
class _SelectedCapsule extends StatelessWidget {
  const _SelectedCapsule({required this.count, required this.selectedIndex});

  final int count;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets inset = SdContentPaddingV3.selectedTabInset;

    return AnimatedAlign(
      duration: SdMotionV3.normal,
      curve: SdMotionV3.emphasized,
      alignment: AlignmentDirectional(
        count == 1 ? 0 : -1 + 2 * selectedIndex / (count - 1),
        0,
      ),
      child: FractionallySizedBox(
        widthFactor: 1 / count,
        heightFactor: 1,
        child: Padding(
          padding: inset,
          child: DecoratedBox(
            key: SdGlassNavBarV3.selectedCapsuleKey,
            decoration: BoxDecoration(
              color: context.colorScheme3.primary.withValues(
                alpha: SdGlassV3.selectedThumbOpacity,
              ),
              borderRadius: BorderRadius.circular(
                SdContentPaddingV3.selectedTabRadius,
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

/// Marks its subtree for layout whenever [listenable] ticks.
///
/// The dirty mark climbs through the glass above it, and laying the glass out
/// is the one public way to make it rebuild its cached shape — see
/// [SdGlassNavBarV3.movement].
class _RelayoutOnTick extends SingleChildRenderObjectWidget {
  const _RelayoutOnTick({required this.listenable, required super.child});

  final Listenable? listenable;

  @override
  _RenderRelayoutOnTick createRenderObject(BuildContext context) =>
      _RenderRelayoutOnTick(listenable);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderRelayoutOnTick renderObject,
  ) => renderObject.listenable = listenable;
}

class _RenderRelayoutOnTick extends RenderProxyBox {
  _RenderRelayoutOnTick(this._listenable);

  Listenable? _listenable;

  set listenable(Listenable? value) {
    if (value == _listenable) return;
    if (attached) _listenable?.removeListener(_onTick);
    _listenable = value;
    if (attached) _listenable?.addListener(_onTick);
  }

  void _onTick() {
    // A tick raised mid-layout cannot dirty layout; the next frame catches it.
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (attached) markNeedsLayout();
      });
      return;
    }

    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _listenable?.addListener(_onTick);
  }

  @override
  void detach() {
    _listenable?.removeListener(_onTick);
    super.detach();
  }
}
