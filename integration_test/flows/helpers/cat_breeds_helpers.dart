import 'package:flutter_test/flutter_test.dart';

import '../../common/interactions/enter_interactions.dart';
import '../../common/tasks/test.dart';
import '../finders/cat_breeds_finders.dart';

final class CatBreedsHelpers {
  static Future<void> goToLandingPage(WidgetTester tester) async {
    await Test.initApp(tester);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }

  static Future<void> goToDetailPage(WidgetTester tester) async {
    await CatBreedsHelpers.goToLandingPage(tester);
    await EnterInteractions.tap(
      tester,
      CatBreedsFinders.textButtonFristBreedPage0,
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }
}
