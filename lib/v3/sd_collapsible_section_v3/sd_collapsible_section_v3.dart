import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v3/sd_content_padding_v3.dart';
import '../sd_context_v3/sd_context_v3.dart';
import '../sd_icon_v3/sd_icon_v3.dart';
import '../sd_motion_v3/sd_motion_v3.dart';
import '../sd_text_style_v3/sd_text_style_v3.dart';

/// A section that folds to one line: a heading, a [summary] of what is
/// inside, and a chevron — the rest one tap away.
///
/// **What the screen needs to decide is open; everything else folds.** The
/// summary is what makes folding honest: a closed section still says what it
/// holds ("Goodwill · B2"), so the seller decides whether to open it without
/// opening it.
///
/// - **Controlled or not.** Pass [expanded] and [onExpandedChanged] when the
///   screen owns the state — a detail screen opens a section when its Edit is
///   pressed; leave them out and the section remembers its own.
/// - [action] sits at the end of the heading and does not toggle — an Edit
///   button there must not also fold the section it edits.
/// - Motion is `SdMotionV3`, and none at all under reduced motion.
/// - **It carries no gutter**, like `SdSectionHeaderV3`.
class SdCollapsibleSectionV3 extends StatefulWidget {
  const SdCollapsibleSectionV3({
    required this.title,
    required this.child,
    this.summary,
    this.leading,
    this.action,
    this.expanded,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
    this.first = false,
    super.key,
  });

  final String title;

  /// One line describing what is inside, shown while folded.
  final String? summary;
  final Widget? leading;
  final Widget? action;
  final Widget child;

  /// Whether it is open, when the caller owns the state.
  final bool? expanded;

  /// The starting state, when the section owns it.
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpandedChanged;

  /// Drops the gap above, as `SdSectionHeaderV3.first` does.
  final bool first;

  @override
  State<SdCollapsibleSectionV3> createState() => _SdCollapsibleSectionV3State();
}

class _SdCollapsibleSectionV3State extends State<SdCollapsibleSectionV3>
    with SingleTickerProviderStateMixin {
  late bool _open = widget.expanded ?? widget.initiallyExpanded;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SdMotionV3.normal,
    value: _open ? 1 : 0,
  );
  late final CurvedAnimation _size = CurvedAnimation(
    parent: _controller,
    curve: SdMotionV3.emphasized,
  );

  @override
  void didUpdateWidget(SdCollapsibleSectionV3 oldWidget) {
    final bool? next = widget.expanded;

    super.didUpdateWidget(oldWidget);
    if (next != null && next != _open) _animateTo(next);
  }

  @override
  void dispose() {
    _size.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(bool open) {
    _open = open;
    _controller.duration = SdMotionV3.of(context, SdMotionV3.normal);
    open ? _controller.forward() : _controller.reverse();
    setState(() {});
  }

  void _toggle() {
    final bool next = !_open;

    if (widget.expanded == null) _animateTo(next);
    widget.onExpandedChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _Header(
        title: widget.title,
        summary: widget.summary,
        leading: widget.leading,
        action: widget.action,
        open: _open,
        first: widget.first,
        onTap: _toggle,
      ),
      SizeTransition(
        sizeFactor: _size,
        alignment: Alignment.topCenter,
        child: FadeTransition(opacity: _size, child: widget.child),
      ),
    ],
  );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.summary,
    required this.leading,
    required this.action,
    required this.open,
    required this.first,
    required this.onTap,
  });

  final String title;
  final String? summary;
  final Widget? leading;
  final Widget? action;
  final bool open;
  final bool first;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Duration fast = SdMotionV3.of(context, SdMotionV3.fast);
    final Duration normal = SdMotionV3.of(context, SdMotionV3.normal);

    return Padding(
      padding: SdContentPaddingV3.sectionHeader(first: first),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Semantics(
              button: true,
              expanded: open,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(SdSpacingConstant.r8),
                child: Row(
                  children: <Widget>[
                    if (leading != null) ...<Widget>[
                      leading!,
                      SizedBox(width: SdSpacingConstant.w8),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            title,
                            style: context.textTheme3.titleMedium!.semiBold3
                                .copyWith(color: context.sdTheme3.textPrimary),
                          ),
                          if (summary != null)
                            AnimatedOpacity(
                              opacity: open ? 0 : 1,
                              duration: fast,
                              curve: SdMotionV3.standard,
                              child: Text(
                                summary!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme3.bodySmall!.muted3(
                                  context,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: open ? 0.5 : 0,
                      duration: normal,
                      curve: SdMotionV3.emphasized,
                      child: SdIconV3(
                        Symbols.keyboard_arrow_down_rounded,
                        color: context.sdTheme3.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
