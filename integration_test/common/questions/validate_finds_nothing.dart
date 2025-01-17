import 'package:flutter_test/flutter_test.dart';

final class ValidateFindsNothing {
  static Future<void> validate(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    expect(finder, findsNothing);
    await tester.pumpAndSettle();
  }
}
