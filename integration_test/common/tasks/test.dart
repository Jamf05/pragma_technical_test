import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/environment/mock/main.dart' as app;

import 'dependency_injection_task.dart';

final class Test {
  static Future<void> initApp(WidgetTester tester) async {
    await tester.pumpAndSettle();
    await DependencyInjectionTask.resetInstance(tester);
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
}
