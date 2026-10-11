import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v3/sd_context_v3.dart';
import '../sd_icon_v3/sd_icon_v3.dart';
import '../sd_text_style_v3/sd_text_style_v3.dart';

/// One thing a swipe does: a glyph and a word, never the glyph alone.
class SdSwipeActionV3 {
  const SdSwipeActionV3({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTriggered,
  });

  final IconData icon;
  final String label;

  /// The panel the swipe reveals — a saturated colour, since the label is
  /// drawn on it in `onPrimary`. The word is there so colour is never the
  /// only signal.
  final Color color;
  final VoidCallback onTriggered;
}

/// A row with up to two swipe actions — one each way.
///
/// **A swipe acts and the row springs back; it never removes the row.**
/// Whether the record leaves the list is the list's business, decided by the
/// data the action changes — a row that vanished on its own before the write
/// landed would be a row the seller cannot find if the write failed.
///
/// The row stays fully usable without swiping: every action here must also
/// be reachable from the row's own menu, because a swipe is invisible.
class SdSwipeRowV3 extends StatelessWidget {
  const SdSwipeRowV3({
    required this.child,
    required this.rowKey,
    this.startAction,
    this.endAction,
    super.key,
  });

  final Widget child;

  /// Identifies the row among its siblings, as `Dismissible` requires.
  final Key rowKey;

  /// Revealed by a swipe from the leading edge.
  final SdSwipeActionV3? startAction;

  /// Revealed by a swipe from the trailing edge.
  final SdSwipeActionV3? endAction;

  @override
  Widget build(BuildContext context) {
    final SdSwipeActionV3? start = startAction;
    final SdSwipeActionV3? end = endAction;

    if (start == null && end == null) return child;

    return Dismissible(
      key: rowKey,
      direction: start != null && end != null
          ? DismissDirection.horizontal
          : start != null
          ? DismissDirection.startToEnd
          : DismissDirection.endToStart,
      background: start == null
          ? const SizedBox.shrink()
          : _Panel(action: start, alignment: AlignmentDirectional.centerStart),
      secondaryBackground: end == null
          ? null
          : _Panel(action: end, alignment: AlignmentDirectional.centerEnd),
      confirmDismiss: (DismissDirection direction) async {
        final SdSwipeActionV3? action = direction == DismissDirection.startToEnd
            ? start
            : end;

        action?.onTriggered();

        return false;
      },
      child: child,
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.action, required this.alignment});

  final SdSwipeActionV3 action;
  final AlignmentDirectional alignment;

  @override
  Widget build(BuildContext context) {
    final Color ink = context.colorScheme3.onPrimary;

    return Container(
      color: action.color,
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SdIconV3(action.icon, color: ink),
          SizedBox(width: SdSpacingConstant.w8),
          Flexible(
            child: Text(
              action.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme3.labelLarge!.semiBold3.copyWith(
                color: ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
