import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_elevation_v5/sd_elevation_v5.dart';
import '../sd_icon_v5/sd_icon_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';
import '../sd_radius_v5/sd_radius_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// What a toast reports. The glyph changes with the accent, so the kind is
/// never told by colour alone.
enum SdSnackBarKindV5 { success, error, info }

/// Shows a toast that drops in from the top, stays [SdMotionV5.snackBar] and
/// leaves the way it came — or sooner, on a swipe up or sideways.
///
/// One at a time: a new message replaces the one on screen, so ten taps on
/// "add to bag" leave one toast, not a stack.
final class SdSnackBarUtilsV5 {
  static OverlayEntry? _current;

  static void success(BuildContext context, String message) =>
      _show(context, message, SdSnackBarKindV5.success);

  static void error(BuildContext context, String message) =>
      _show(context, message, SdSnackBarKindV5.error);

  static void info(BuildContext context, String message) =>
      _show(context, message, SdSnackBarKindV5.info);

  static void dismiss() {
    _current?.remove();
    _current = null;
  }

  static void _show(
    BuildContext context,
    String message,
    SdSnackBarKindV5 kind,
  ) {
    final OverlayState? overlay = Overlay.maybeOf(context, rootOverlay: true);

    if (overlay == null) return;

    dismiss();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext context) => _SnackBarHost(
        message: message,
        kind: kind,
        onDismissed: () {
          if (_current == entry) dismiss();
        },
      ),
    );

    _current = entry;
    overlay.insert(entry);
  }
}

class _SnackBarHost extends StatefulWidget {
  const _SnackBarHost({
    required this.message,
    required this.kind,
    required this.onDismissed,
  });

  final String message;
  final SdSnackBarKindV5 kind;
  final VoidCallback onDismissed;

  @override
  State<_SnackBarHost> createState() => _SnackBarHostState();
}

class _SnackBarHostState extends State<_SnackBarHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SdMotionV5.normal,
    reverseDuration: SdMotionV5.fast,
  );
  Timer? _timer;
  Offset _drag = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(SdMotionV5.snackBar, _leave);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _leave() async {
    _timer?.cancel();

    if (!mounted) return;

    await _controller.reverse();
    widget.onDismissed();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _timer?.cancel();
    setState(() {
      _drag = Offset(
        _drag.dx + details.delta.dx,
        (_drag.dy + details.delta.dy).clamp(double.negativeInfinity, 0),
      );
    });
  }

  void _onDragEnd(DragEndDetails _) {
    if (_drag.dy < -SdSpacingConstant.h24 ||
        _drag.dx.abs() > SdSpacingConstant.w64) {
      _leave();
      return;
    }

    setState(() => _drag = Offset.zero);
    _timer = Timer(SdMotionV5.snackBar, _leave);
  }

  @override
  Widget build(BuildContext context) {
    final (IconData glyph, Color accent) = switch (widget.kind) {
      SdSnackBarKindV5.success => (
        Symbols.check_circle_rounded,
        context.sdTheme5.success,
      ),
      SdSnackBarKindV5.error => (
        Symbols.error_rounded,
        context.sdTheme5.danger,
      ),
      SdSnackBarKindV5.info => (Symbols.info_rounded, context.sdTheme5.info),
    };
    final Animation<double> curved = CurvedAnimation(
      parent: _controller,
      curve: SdMotionV5.standard,
      reverseCurve: SdMotionV5.exit,
    );

    return Positioned(
      top: SdContentPaddingV5.statusBarInset(context) + SdSpacingConstant.h8,
      left: SdContentPaddingV5.horizontal,
      right: SdContentPaddingV5.horizontal,
      child: SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: _onDragUpdate,
          onPanEnd: _onDragEnd,
          child: FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.6),
                end: Offset.zero,
              ).animate(curved),
              child: Transform.translate(
                offset: _drag,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SdSpacingConstant.w16,
                      vertical: SdSpacingConstant.h14,
                    ),
                    decoration: BoxDecoration(
                      color: context.sdTheme5.textPrimary,
                      borderRadius: SdRadiusV5.cardAll,
                      boxShadow: SdElevationV5.high(context),
                    ),
                    child: Row(
                      children: <Widget>[
                        SdIconV5(glyph, color: accent, fill: 1),
                        SizedBox(width: SdSpacingConstant.w12),
                        Expanded(
                          child: Text(
                            widget.message,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme5.bodyMedium!.medium5
                                .copyWith(color: context.sdTheme5.background),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
