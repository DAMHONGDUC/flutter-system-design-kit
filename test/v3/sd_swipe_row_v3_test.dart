import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';

/// A swipe acts and the row springs back — it is never removed by the swipe.
void main() {
  testWidgets('a swipe triggers its action and the row stays', (
    WidgetTester tester,
  ) async {
    int archived = 0;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, Widget? _) => MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const <ThemeExtension<dynamic>>[SdThemeV3.fallback],
          ),
          home: Scaffold(
            body: SdSwipeRowV3(
              rowKey: const ValueKey<String>('row'),
              endAction: SdSwipeActionV3(
                icon: Symbols.archive_rounded,
                label: 'Archive',
                color: Colors.orange,
                onTriggered: () => archived++,
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 64,
                child: Text('Jacket'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.fling(find.text('Jacket'), const Offset(-500, 0), 1000);
    await tester.pumpAndSettle();

    expect(archived, 1);
    expect(find.text('Jacket'), findsOneWidget);
  });
}
