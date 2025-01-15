import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pragma_technical_test/environment/mock/main.dart' as app;
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const tItemCatBreedCardKey = Key('ptt_item_cat_breed_card_abys_key');

  setUp(() async {
    await GetIt.instance.reset();
  });

  group('splash', () {
    testWidgets('should show splash page', (WidgetTester tester) async {
      // arrange
      await app.main();

      // act
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(SplashPage), findsOneWidget);
    });
  });

  group('landing', () {
    testWidgets('should show landing page', (WidgetTester tester) async {
      // arrange
      await app.main();
      await tester.pumpAndSettle();

      // act
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(LandingPage), findsOneWidget);
    });
  });

  group('detail', () {
    testWidgets('should show detail page', (WidgetTester tester) async {
      // arrange
      await app.main();

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // act
      final catBreedCardFinder = find.byKey(tItemCatBreedCardKey);
      final textButtonFinder = find.descendant(
        of: catBreedCardFinder,
        matching: find.byType(TextButton),
      );

      await tester.tap(textButtonFinder);

      await tester.pumpAndSettle();

      // assert
      expect(find.byType(DetailPage), findsOneWidget);
    });
  });
}
