import 'package:flutter/material.dart';

import '../sd_context_v5/sd_context_v5.dart';

/// The platform switch in v5's ink: a Cupertino track on iOS, Material
/// elsewhere, both reading the theme.
class SdSwitchV5 extends StatelessWidget {
  const SdSwitchV5({
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticLabel,
    toggled: value,
    child: Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeTrackColor: context.sdTheme5.textPrimary,
      activeThumbColor: context.sdTheme5.background,
      inactiveTrackColor: context.sdTheme5.surfaceSunken,
    ),
  );
}
