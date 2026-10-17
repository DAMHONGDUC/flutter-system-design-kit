import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_chip_v5/sd_chip_v5.dart';
import '../sd_content_padding_v5/sd_content_padding_v5.dart';
import '../sd_motion_v5/sd_motion_v5.dart';

/// A horizontally scrolling row of [SdChipV5] tabs — order statuses, product
/// categories. The selected tab is scrolled into view when it changes, so a
/// tab picked from elsewhere is never left off screen.
class SdTabsV5 extends StatefulWidget {
  const SdTabsV5({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.padding,
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// Defaults to the page gutter on both sides.
  final EdgeInsets? padding;

  @override
  State<SdTabsV5> createState() => _SdTabsV5State();
}

class _SdTabsV5State extends State<SdTabsV5> {
  late List<GlobalKey> _keys = _makeKeys();

  List<GlobalKey> _makeKeys() =>
      List<GlobalKey>.generate(widget.labels.length, (int _) => GlobalKey());

  @override
  void didUpdateWidget(SdTabsV5 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.labels.length != widget.labels.length) _keys = _makeKeys();

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        final BuildContext? target = _keys[widget.selectedIndex].currentContext;

        if (target == null || !mounted) return;

        Scrollable.ensureVisible(
          target,
          alignment: 0.5,
          duration: SdMotionV5.of(context, SdMotionV5.normal),
          curve: SdMotionV5.standard,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: widget.padding ?? SdContentPaddingV5.gutter,
    child: Row(
      children: <Widget>[
        for (final (int i, String label) in widget.labels.indexed) ...<Widget>[
          if (i > 0) SizedBox(width: SdSpacingConstant.w8),
          SdChipV5(
            key: _keys[i],
            label: label,
            selected: i == widget.selectedIndex,
            onSelected: () => widget.onSelected(i),
          ),
        ],
      ],
    ),
  );
}
