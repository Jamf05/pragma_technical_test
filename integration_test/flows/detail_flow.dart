import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../common/common.dart';
import 'finders/cat_breeds_finders.dart';
import 'helpers/cat_breeds_helpers.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  setUp(() {});

  testWidgets(
    'IT_03_01: should be able to navigate to the detail screen',
    (WidgetTester tester) async {
      await CatBreedsHelpers.goToDetailPage(tester);

      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.detailPage,
      );
    },
  );

  testWidgets(
    'IT_03_02: should be able to scroll',
    (WidgetTester tester) async {
      await CatBreedsHelpers.goToDetailPage(tester);

      await ScrollInteractions.scrollDown(
        tester,
      );

      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.scrollable,
      );
    },
  );

  testWidgets(
    'IT_03_03: should be able to return to landing page',
    (WidgetTester tester) async {
      await CatBreedsHelpers.goToDetailPage(tester);

      await NavigatorInteractions.back(
        tester,
      );

      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.landingPage,
      );
    },
  );
}
