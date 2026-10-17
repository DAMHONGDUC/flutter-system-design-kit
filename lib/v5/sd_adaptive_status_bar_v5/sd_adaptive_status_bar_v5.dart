import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that automatically detects and sets the status bar icon color
/// based on the background color.
class SdAdaptiveStatusBarV5 extends StatelessWidget {
  /// The child widget to be wrapped.
  final Widget child;

  /// The background color used to auto-detect icon brightness (required).
  final Color backgroundColor;

  /// Status bar color (default: transparent).
  final Color? statusBarColor;

  /// Manually override icon brightness (if you don’t want auto-detect).
  final Brightness? statusBarIconBrightness;

  /// Whether to also apply the settings to the navigation bar.
  final bool applyToNavigationBar;

  /// Navigation bar color (default: backgroundColor).
  final Color? navigationBarColor;

  /// Override navigation bar icon brightness.
  final Brightness? navigationBarIconBrightness;

  const SdAdaptiveStatusBarV5({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.applyToNavigationBar = false,
    this.navigationBarColor,
    this.navigationBarIconBrightness,
  });

  @override
  Widget build(BuildContext context) {
    // Auto-detect icon brightness from the background color
    final backgroundBrightness = ThemeData.estimateBrightnessForColor(
      backgroundColor,
    );
    final autoIconBrightness = backgroundBrightness == Brightness.dark
        ? Brightness
              .light // Dark background → White icons
        : Brightness.dark; // Light background → Dark icons

    // Use manual override if provided, otherwise auto-detect
    final finalIconBrightness = statusBarIconBrightness ?? autoIconBrightness;
    final finalNavIconBrightness =
        navigationBarIconBrightness ?? autoIconBrightness;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar settings
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness: finalIconBrightness,
        statusBarBrightness: finalIconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light, // iOS compatibility
        // Navigation bar settings (optional)
        systemNavigationBarColor: applyToNavigationBar
            ? (navigationBarColor ?? backgroundColor)
            : null,
        systemNavigationBarIconBrightness: applyToNavigationBar
            ? finalNavIconBrightness
            : null,
      ),
      child: child,
    );
  }
}
