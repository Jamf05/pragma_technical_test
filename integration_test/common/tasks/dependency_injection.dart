import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final class DependencyInjection {
  static Future<void> resetInstance(WidgetTester tester) async {
    await GetIt.instance.reset();
  }
}
