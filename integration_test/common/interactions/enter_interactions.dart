import 'package:flutter_test/flutter_test.dart';

final class EnterInteractions {
  static Future<void> textWith(
      WidgetTester tester, Finder finder, String text) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }
}
