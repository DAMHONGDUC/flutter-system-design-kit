import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_count_badge_v5/sd_count_badge_v5.dart';
import '../sd_elevation_v5/sd_elevation_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_pressable_v5/sd_pressable_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// One tab of an [SdNavBarV5].
@immutable
class SdNavDestinationV5 {
  const SdNavDestinationV5({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;

  /// Items in the bag, unread notifications. Zero hides the badge.
  final int badgeCount;
}

/// The floating tab bar: a frosted pill over the content with an ink capsule
/// that slides to the selected tab, which alone shows its label.
///
/// It floats rather than taking a layout slot, so a tab screen pads its
/// scroll view by `SdContentPaddingV5.aboveNavBar`.
class SdNavBarV5 extends StatelessWidget {
  const SdNavBarV5({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<SdNavDestinationV5> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      SdContentPaddingV5.navBarMargin,
      0,
      SdContentPaddingV5.navBarMargin,
      SdContentPaddingV5.navBarOffset(context),
    ),
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: SdRadiusV5.fullAll,
        boxShadow: SdElevationV5.high(context),
      ),
      child: ClipRRect(
        borderRadius: SdRadiusV5.fullAll,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: SdContentPaddingV5.navBarHeight,
            padding: EdgeInsets.all(SdSpacingConstant.r6),
            color: context.sdTheme5.surface.withValues(alpha: 0.88),
            child: Row(
              children: <Widget>[
                for (final (int i, SdNavDestinationV5 d)
                    in destinations.indexed)
                  Expanded(
                    flex: i == selectedIndex ? 5 : 3,
                    child: _NavItem(
                      destination: d,
                      selected: i == selectedIndex,
                      onTap: () => onSelected(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final SdNavDestinationV5 destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Color foreground = selected ? context.sdTheme5.background : ink;
    final Duration duration = SdMotionV5.of(context, SdMotionV5.normal);

    return Semantics(
      selected: selected,
      button: true,
      label: destination.label,
      excludeSemantics: true,
      child: SdPressableV5(
        onTap: onTap,
        pressedScale: 0.92,
        child: AnimatedContainer(
          duration: duration,
          curve: SdMotionV5.standard,
          decoration: BoxDecoration(
            color: selected ? ink : Colors.transparent,
            borderRadius: SdRadiusV5.fullAll,
          ),
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(end: selected ? 1 : 0),
                      duration: duration,
                      builder: (BuildContext context, double fill, Widget? _) =>
                          SdIconV5(
                            destination.icon,
                            size: SdIconV5.largeSize,
                            fill: fill,
                            color: foreground,
                          ),
                    ),
                    Positioned(
                      top: -SdSpacingConstant.h6,
                      right: -SdSpacingConstant.w8,
                      child: SdCountBadgeV5(count: destination.badgeCount),
                    ),
                  ],
                ),
                Flexible(
                  child: AnimatedSize(
                    duration: duration,
                    curve: SdMotionV5.standard,
                    child: selected
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: SdSpacingConstant.w8,
                            ),
                            child: Text(
                              destination.label,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: context.textTheme5.labelLarge!.semiBold5
                                  .copyWith(color: foreground),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
