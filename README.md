# flutter-system-design-kit

Dart package `system_design`. The shared design system: presentation-only widgets, spacing primitives, and
the theme *contract* they read. Consumed by an app as a path dependency on a
git submodule.

**The palette is not in here.** The host app owns its colours and text styles
and hands them over through a `ThemeExtension`, so the same widget set renders
in a different brand without a line changing here.

## Use it

**Depend on core and the one generation the app renders** — each generation
is its own package, so an app pays for its generation's dependencies and no
other's (v5's video plugins stay out of an app on v3):

```yaml
dependencies:
  system_design_core:
    path: packages/flutter-system-design-kit/packages/system_design_core
  system_design_v3:
    path: packages/flutter-system-design-kit/packages/system_design_v3
```

```dart
import 'package:system_design_v3/v3.dart';      // widgets, tokens and core
import 'package:system_design_core/common.dart'; // pure Dart, from domain/
```

`system_design` (the kit root) is the umbrella: it re-exports every
generation through `package:system_design/index.dart`, for apps that have not
moved yet, and drags in every generation's dependencies with it.

Then register the theme contract once, in the app's own `ThemeData`:

```dart
ThemeData(
  colorScheme: scheme,
  textTheme: textTheme,
  extensions: <ThemeExtension<dynamic>>[
    SdThemeV2(
      background: AppColors.background,
      surfaceElevated: AppColors.surfaceElevated,
      textPrimary: AppColors.textPrimary,
      textSecondary: AppColors.textSecondary,
      chartGrid: AppColors.chartGrid,
      barrier: AppColors.barrier,
    ),
  ],
)
```

Widgets read `context.colorScheme` and `context.textTheme` for everything
Material already names, and `context.sdTheme` for the six slots it does not.
Forgetting to register it asserts at the first widget that needs a colour —
loudly, rather than rendering the wrong thing.

## Layout

```
pubspec.yaml                    # system_design — the umbrella, every generation re-exported
lib/
  index.dart                    # umbrella entry point, for apps not yet on a generation package
  common.dart                   # umbrella re-export of system_design_core/common.dart
packages/
  system_design_core/           # what every generation shares
    lib/
      core.dart                 # core + common + utils, re-exported by every generation
      common.dart               # pure-Dart entry point, safe from domain/
      core/                     # dimensions, startup, breakpoints, common/ (logger, ids, crash reporter)
      utils/
  system_design_v3/             # one package per generation: v2, v3, v4, v5
    lib/
      v3.dart                   # the entry point an app on v3 imports
      sd_button_v3/
        sd_button_v3.dart
      …                         # one folder per widget
    test/
```

`core/` is what does not belong to a widget generation: `SdSpacingConstant`,
the screenutil dimensions any version of the system measures in. It carries no
look, so it carries no version.

`v2`, `v3`, `v4`, and `v5` are isolated generations. Finances Calculator consumes
`v4`; Tuku Shop consumes `v5`, ported from the `system_design_flutter`
package and used by no other app. Prior generations remain frozen for their
existing products.

Each generation owns everything that does have a look. A future generation
gets its own package under `packages/`, depending on `system_design_core` and
nothing else of the kit, and is re-exported from the umbrella `lib/index.dart`
too, so an app can migrate widget by widget instead of all at once.

## What is in v2

**Tokens and contract** — `SdSpacingConstant` (in `core/`), `SdContentPaddingV2`, `SdThemeV2`,
`SdContextV2X` (`context.theme` / `.colorScheme` / `.textTheme` / `.sdTheme`),
`SdTextStyleV2X` (`.semiBold`, `.muted(context)`).

**Chrome** — `SdScaffoldV2`, `SdAppBarV2`, `SdAppBarButtonV2`,
`SdGlassCircleV2`, `SdGlassV2`, `SdPinnedFilterBarV2`,
`SdCollapsingFilterScaffoldV2`, `SdActionViewV2`.

**Controls** — `SdButtonV2`, `SdIconButtonV2`, `SdIconV2`, `SdSwitcherV2`,
`SdValueSliderV2`, `SdFilterPillV2`, `SdFilterChipV2`.

**Surfaces** — `showSdDialogV2` / `SdDialogV2`, `showSdBottomSheetV2`,
`SdSheetHeaderV2`, `SdSheetContentV2`, `showSdFilterSheetV2`,
`SdSnackBarUtilsV2`.

**Content** — `SdBannerV2`, `SdBenefitRowV2`, `SdSectionHeaderV2`,
`SdEmptyStateV2`, `SdIconBadgeV2`, `SdColorDotV2`, `SdFittedTextV2`,
`SdRefreshIndicatorV2`, spacing widgets.

**Charts** — `SdChartFrameV2` (title + VoiceOver summary + plot),
`SdChartCardV2`, `SdChartStyleV2` (axes, grid, tooltips), `SdBarChartV2`,
`SdDonutChartV2` + `SdDonutLegendV2`, `SdProgressRowV2`.

**Motion** — `SdPressableScaleV2`, `SdPopScaleV2`.

## What is deliberately NOT in here

Anything that needs a string of its own or reaches into an app. In the
migraine tracker that leaves, in `lib/core/widgets/`: `AppTimePickerSheet`,
`MedicationNameDialog`, `PermissionSettingsSheet` (localized copy),
`PremiumGate` (watches a provider), `SeverityBreakdownChart` (reads the app's
severity bands, then composes `SdDonutChartV2`), and `sections/` (settings
rows bound to app features).

That boundary is the whole point. See **[WIDGET_RULES.md](WIDGET_RULES.md)**
before adding anything.

## The release pipeline is not in here

The scripts and the shared iOS lanes live in
[script-tools](https://github.com/DAMHONGDUC/script-tools) under `flutter/`,
a submodule of its own beside this one (`packages/script-tools`). This package
holds widgets only.

## Check

```bash
cd packages/flutter-system-design-kit
flutter analyze     # must pass standalone, without the host app
```
