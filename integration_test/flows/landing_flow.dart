import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../common/common.dart';
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
        tester,
        CatBreedsFinders.landingPage,
      );
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
    'IT_02_03: should show the next page',
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

  testWidgets(
    'IT_02_04: should be able to click on the first item',
    (WidgetTester tester) async {
      // arrange
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // act
      await EnterInteractions.tap(
        tester,
        CatBreedsFinders.textButtonFristBreedPage0,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // assert
      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.detailPage,
      );
    },
  );

  testWidgets(
    'IT_02_05: should be able to type in the text field',
    (WidgetTester tester) async {
      // arrange
      const tQuery = 'aegean';
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // act
      await EnterInteractions.textWith(
        tester,
        CatBreedsFinders.textField,
        tQuery,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // assert
      await ValidateTextFindsOneWidget.validate(
        tester,
        tQuery,
      );
    },
  );

  testWidgets(
    'IT_02_06: should be able to search for an item',
    (WidgetTester tester) async {
      // arrange
      const tQuery = 'aegean';
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // act
      await EnterInteractions.textWith(
        tester,
        CatBreedsFinders.textField,
        tQuery,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      // assert
      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.aegeCatBreed,
      );
    },
  );

  testWidgets(
    'IT_02_07: should be able to change the theme to dark',
    (WidgetTester tester) async {
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await EnterInteractions.tap(
        tester,
        CatBreedsFinders.landingThemeButtonKey,
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.wbSunnyOutlinedIcon,
      );

      await ValidateExpectTheme.validate(
        tester,
        CatBreedsFinders.landingPage,
        brightness: Brightness.dark,
      );
    },
  );

  testWidgets(
    'IT_02_08: should be able to change the theme to light',
    (WidgetTester tester) async {
      await Test.initApp(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await EnterInteractions.tap(
        tester,
        CatBreedsFinders.landingThemeButtonKey,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await EnterInteractions.tap(
        tester,
        CatBreedsFinders.landingThemeButtonKey,
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await ValidateFindsOneWidget.validate(
        tester,
        CatBreedsFinders.nightlightRoundIcon,
      );

      await ValidateExpectTheme.validate(
        tester,
        CatBreedsFinders.landingPage,
        brightness: Brightness.light,
      );
    },
  );
}
