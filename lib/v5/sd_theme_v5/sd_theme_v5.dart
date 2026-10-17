import 'package:flutter/material.dart';

/// The palette contract of System Design v5 — the generation built for Tuku
/// Shop, a fashion storefront.
///
/// The host app owns every colour and hands them over by registering this
/// extension on its `ThemeData`. Material already names the brand slots
/// (`primary`, `onPrimary`, `error` …) on the [ColorScheme]; this carries the
/// ones a storefront needs that Material does not: the warm page and card
/// layers product photography sits on, the sale accent, the rating star, and
/// the two shimmer tones.
@immutable
class SdThemeV5 extends ThemeExtension<SdThemeV5> {
  const SdThemeV5({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceSunken,
    required this.photoBackdrop,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textPlaceholder,
    required this.border,
    required this.divider,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.rating,
    required this.barrier,
    required this.shadow,
    required this.skeletonBase,
    required this.skeletonHighlight,
  });

  /// The page behind everything.
  final Color background;

  /// Cards, bars and sheets sitting on [background].
  final Color surface;

  /// A layer above [surface] — a chip on a card, a floating bar.
  final Color surfaceElevated;

  /// Wells: a search field, a stepper, an unselected chip.
  final Color surfaceSunken;

  /// Behind a product photo. Studio shots are cut on near-white, so this is
  /// what keeps the photo's edge from reading as a hard rectangle in dark mode.
  final Color photoBackdrop;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textPlaceholder;
  final Color border;
  final Color divider;

  /// The sale / promotion highlight. Never the primary action colour: a
  /// discount badge and a checkout button must not compete.
  final Color accent;
  final Color onAccent;

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  /// A filled rating star.
  final Color rating;

  /// The scrim behind a modal.
  final Color barrier;

  /// The single shadow tone every elevation level is built from.
  final Color shadow;

  /// A placeholder's still colour, and the shimmer band travelling over it.
  final Color skeletonBase;
  final Color skeletonHighlight;

  /// What a widget renders with when the host forgot to register the
  /// extension. Debug builds assert first — see `SdContextV5X.sdTheme5`.
  static const SdThemeV5 fallback = SdThemeV5(
    background: Color(0xFFF7F5F2),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFEFECE8),
    photoBackdrop: Color(0xFFF2F0ED),
    textPrimary: Color(0xFF151515),
    textSecondary: Color(0xFF5F5B57),
    textTertiary: Color(0xFF8F8A85),
    textPlaceholder: Color(0xFFB5B0AA),
    border: Color(0xFFE3DFDA),
    divider: Color(0xFFEDEAE6),
    accent: Color(0xFFD9483B),
    onAccent: Color(0xFFFFFFFF),
    success: Color(0xFF1E8E5A),
    warning: Color(0xFFC77700),
    danger: Color(0xFFC9372C),
    info: Color(0xFF2F6FDB),
    rating: Color(0xFFF2A100),
    barrier: Color(0x8C000000),
    shadow: Color(0x1A1B1410),
    skeletonBase: Color(0xFFECE9E5),
    skeletonHighlight: Color(0xFFF7F5F2),
  );

  @override
  SdThemeV5 copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceSunken,
    Color? photoBackdrop,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textPlaceholder,
    Color? border,
    Color? divider,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? rating,
    Color? barrier,
    Color? shadow,
    Color? skeletonBase,
    Color? skeletonHighlight,
  }) => SdThemeV5(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceElevated: surfaceElevated ?? this.surfaceElevated,
    surfaceSunken: surfaceSunken ?? this.surfaceSunken,
    photoBackdrop: photoBackdrop ?? this.photoBackdrop,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textTertiary: textTertiary ?? this.textTertiary,
    textPlaceholder: textPlaceholder ?? this.textPlaceholder,
    border: border ?? this.border,
    divider: divider ?? this.divider,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    danger: danger ?? this.danger,
    info: info ?? this.info,
    rating: rating ?? this.rating,
    barrier: barrier ?? this.barrier,
    shadow: shadow ?? this.shadow,
    skeletonBase: skeletonBase ?? this.skeletonBase,
    skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
  );

  @override
  SdThemeV5 lerp(covariant SdThemeV5? other, double t) {
    if (other == null) return this;

    return SdThemeV5(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceSunken: Color.lerp(surfaceSunken, other.surfaceSunken, t)!,
      photoBackdrop: Color.lerp(photoBackdrop, other.photoBackdrop, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
      barrier: Color.lerp(barrier, other.barrier, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      skeletonBase: Color.lerp(skeletonBase, other.skeletonBase, t)!,
      skeletonHighlight: Color.lerp(
        skeletonHighlight,
        other.skeletonHighlight,
        t,
      )!,
    );
  }
}
