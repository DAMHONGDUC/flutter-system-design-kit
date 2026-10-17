import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';

/// A hairline. [indent] lines it up with the text of a row that has a
/// leading icon.
class SdDividerV5 extends StatelessWidget {
  const SdDividerV5({this.indent = 0, this.spacing, super.key});

  final double indent;

  /// Vertical room around the line. Defaults to the line alone.
  final double? spacing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: indent),
    child: Divider(
      height: spacing ?? SdSpacingConstant.h1,
      thickness: SdSpacingConstant.h1,
      color: context.sdTheme5.divider,
    ),
  );
}
