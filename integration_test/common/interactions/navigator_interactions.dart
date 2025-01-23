import 'package:flutter_test/flutter_test.dart';

final class NavigatorInteractions {
  static Future<void> back(WidgetTester tester) async {
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
}