import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

final class ScrollInteractions {
  static Future<void> scrollDown(WidgetTester tester,
      {Offset offset = const Offset(0, -300)}) async {
    await tester.drag(find.byType(Scrollable), offset);
    await tester.pumpAndSettle();
  }

  static Future<void> scrollDownFinder(WidgetTester tester, Finder finder,
      {Offset offset = const Offset(0, -300)}) async {
    await tester.drag(finder, offset);
    await tester.pumpAndSettle();
  }
}
