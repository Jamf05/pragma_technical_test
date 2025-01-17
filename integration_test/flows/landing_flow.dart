import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../common/interactions/scroll_interactions.dart';
import '../common/questions/validate_finds_one_widget.dart';
import '../common/tasks/test.dart';
import 'finders/cat_breeds_finders.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  setUp(() {});

  testWidgets(
    'IT_02_01: should go to the landing page',
    (WidgetTester tester) async {
      // arrange
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // assert
      await ValidateFindsOneWidget.validate(
          tester, CatBreedsFinders.landingPage);
    },
  );

  testWidgets(
    'IT_02_02: should be able to scroll',
    (WidgetTester tester) async {
      // arrange
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // act
      await ScrollInteractions.scrollDownFinder(
        tester,
        CatBreedsFinders.landingPageListScroll,
        offset: const Offset(0, -5000),
      );

      // assert
      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.lastBreedPage0,
      );
    },
  );

  testWidgets(
    'IT_02_03: should show the following page',
    (WidgetTester tester) async {
      // arrange
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // act
      await ScrollInteractions.scrollDownFinder(
        tester,
        CatBreedsFinders.landingPageListScroll,
        offset: const Offset(0, -5000),
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      await ScrollInteractions.scrollDownFinder(
        tester,
        CatBreedsFinders.landingPageListScroll,
        offset: const Offset(0, -5000),
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // assert
      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.lastBreedPage1,
      );
    },
  );
}
