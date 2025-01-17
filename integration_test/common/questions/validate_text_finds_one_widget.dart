import 'package:flutter_test/flutter_test.dart';

final class ValidateTextFindsOneWidget {
  static Future<void> validate(WidgetTester tester, String text) async {
    final finder = find.text(text);
    await tester.ensureVisible(finder);
    expect(finder, findsOneWidget);
    await tester.pumpAndSettle();
  }
}
