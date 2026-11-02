/// System Design — the v3 widget set, built for Reseller Studio.
///
/// An app on v3 imports this file — `package:system_design_v3/v3.dart` — and
/// nothing else: it re-exports `system_design_core`, and v3 is its own package
/// so an app pays only for v3's dependencies, never another generation's.
///
/// **v3 does not import v2, and never will.** The two generations ship side
/// by side so an app can migrate widget by widget; a v3 widget that reached
/// into `v2/` would make that impossible and would drag v2's dark-only,
/// frosted-glass assumptions into a design system that is neither.
///
/// Every widget lives in its own folder under `lib/` and is exported here.
/// Adding a widget means adding one folder and one line below — nothing else
/// in the package changes. See `WIDGET_RULES.md`, which is the authority.
library;

export 'package:system_design_core/core.dart';
export 'sd_app_bar_action_button_v3/sd_app_bar_action_button_v3.dart';
export 'sd_app_bar_v3/sd_app_bar_v3.dart';
export 'sd_badge_v3/sd_badge_v3.dart';
export 'sd_bottom_navigation_v3/sd_bottom_navigation_v3.dart';
export 'sd_bottom_sheet_v3/sd_bottom_sheet_v3.dart';
export 'sd_button_v3/sd_button_v3.dart';
export 'sd_card_v3/sd_card_v3.dart';
export 'sd_collapsible_section_v3/sd_collapsible_section_v3.dart';
export 'sd_content_padding_v3/sd_content_padding_v3.dart';
export 'sd_context_v3/sd_context_v3.dart';
export 'sd_dialog_v3/sd_dialog_v3.dart';
export 'sd_divider_v3/sd_divider_v3.dart';
export 'sd_elevation_v3/sd_elevation_v3.dart';
export 'sd_empty_state_v3/sd_empty_state_v3.dart';
export 'sd_error_view_v3/sd_error_view_v3.dart';
export 'sd_fab_v3/sd_fab_v3.dart';
export 'sd_field_label_v3/sd_field_label_v3.dart';
export 'sd_filter_chip_v3/sd_filter_chip_v3.dart';
export 'sd_floating_bar_scope_v3/sd_floating_bar_scope_v3.dart';
export 'sd_free_limit_progress_v3/sd_free_limit_progress_v3.dart';
export 'sd_glass_nav_bar_v3/sd_glass_nav_bar_v3.dart';
export 'sd_hero_stat_v3/sd_hero_stat_v3.dart';
export 'sd_icon_tile_v3/sd_icon_tile_v3.dart';
export 'sd_icon_v3/sd_icon_v3.dart';
export 'sd_keyboard_dismiss_v3/sd_keyboard_dismiss_v3.dart';
export 'sd_loading_v3/sd_loading_v3.dart';
export 'sd_motion_v3/sd_motion_v3.dart';
export 'sd_nav_cell_v3/sd_nav_cell_v3.dart';
export 'sd_nav_panel_scope_v3/sd_nav_panel_scope_v3.dart';
export 'sd_nav_panel_toggle_v3/sd_nav_panel_toggle_v3.dart';
export 'sd_nav_panel_v3/sd_nav_panel_v3.dart';
export 'sd_radius_v3/sd_radius_v3.dart';
export 'sd_scaffold_v3/sd_scaffold_v3.dart';
export 'sd_search_field_v3/sd_search_field_v3.dart';
export 'sd_search_header_v3/sd_search_header_v3.dart';
export 'sd_section_header_v3/sd_section_header_v3.dart';
export 'sd_snack_bar_v3/sd_snack_bar_v3.dart';
export 'sd_stat_tile_v3/sd_stat_tile_v3.dart';
export 'sd_swipe_row_v3/sd_swipe_row_v3.dart';
export 'sd_tag_v3/sd_tag_v3.dart';
export 'sd_text_field_v3/sd_text_field_v3.dart';
export 'sd_text_style_v3/sd_text_style_v3.dart';
export 'sd_theme_v3/sd_theme_v3.dart';
export 'sd_vendor_button_v3/sd_vendor_button_v3.dart';
