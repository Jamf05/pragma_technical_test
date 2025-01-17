import 'package:flutter_test/flutter_test.dart';

final class ValidateFindsOneWidget {
  static Future<void> validate(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    expect(finder, findsOneWidget);
    await tester.pumpAndSettle();
  }
}
