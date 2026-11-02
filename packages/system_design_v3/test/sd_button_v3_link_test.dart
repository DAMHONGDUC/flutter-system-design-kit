import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_design_v3/v3.dart';

/// A link is type with a rule under it, not a control: muted, underlined,
/// small, and tighter than every other variant.
Future<void> _pump(WidgetTester tester, SdButtonVariantV3 variant) =>
    tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, Widget? child) => MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const <ThemeExtension<dynamic>>[SdThemeV3.fallback],
          ),
          home: Center(
            child: SdButtonV3(
              variant: variant,
              label: 'Terms of Use',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

void main() {
  testWidgets('a link is underlined in the muted text colour', (
    WidgetTester tester,
  ) async {
    await _pump(tester, SdButtonVariantV3.link);

    final Text label = tester.widget<Text>(find.text('Terms of Use'));

    expect(label.style!.decoration, TextDecoration.underline);
    expect(label.style!.color, SdThemeV3.fallback.textSecondary);
  });

  testWidgets('a link is smaller than a text button', (
    WidgetTester tester,
  ) async {
    await _pump(tester, SdButtonVariantV3.text);
    final Size text = tester.getSize(find.byType(SdButtonV3));

    await _pump(tester, SdButtonVariantV3.link);
    final Size link = tester.getSize(find.byType(SdButtonV3));

    expect(link.height, lessThan(text.height));
    expect(link.width, lessThan(text.width));
  });
}
