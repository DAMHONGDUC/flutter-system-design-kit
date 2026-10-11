import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_design/index.dart';

/// A folded section still says what it holds, opens on a tap, and lets a
/// screen open it from outside — an Edit button, say.
Future<void> _pump(WidgetTester tester, Widget child) => tester.pumpWidget(
  ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (BuildContext context, Widget? _) => MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: const <ThemeExtension<dynamic>>[SdThemeV3.fallback],
      ),
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  ),
);

void main() {
  testWidgets('folded, it shows the summary; a tap opens it', (
    WidgetTester tester,
  ) async {
    await _pump(
      tester,
      const SdCollapsibleSectionV3(
        title: 'Provenance',
        summary: 'Goodwill · B2',
        child: Text('Shelf B2'),
      ),
    );

    expect(find.text('Goodwill · B2'), findsOneWidget);
    expect(tester.getSize(find.byType(SizeTransition)).height, 0);

    await tester.tap(find.text('Provenance'));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(SizeTransition)).height, greaterThan(0));
  });

  testWidgets('a controlled section follows its owner', (
    WidgetTester tester,
  ) async {
    bool open = false;

    await tester.pumpWidget(const SizedBox.shrink());
    await _pump(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Column(
          children: <Widget>[
            TextButton(
              onPressed: () => setState(() => open = true),
              child: const Text('Edit'),
            ),
            SdCollapsibleSectionV3(
              title: 'Pricing',
              expanded: open,
              onExpandedChanged: (bool value) => setState(() => open = value),
              child: const Text('Cost'),
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(SizeTransition)).height, greaterThan(0));
  });

  testWidgets('the action beside the title does not fold the section', (
    WidgetTester tester,
  ) async {
    int edits = 0;

    await _pump(
      tester,
      SdCollapsibleSectionV3(
        title: 'Notes',
        initiallyExpanded: true,
        action: TextButton(onPressed: () => edits++, child: const Text('Edit')),
        child: const Text('Fragile'),
      ),
    );

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(edits, 1);
    expect(tester.getSize(find.byType(SizeTransition)).height, greaterThan(0));
  });
}
