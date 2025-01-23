import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_localizations.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_catbreeds.dart';

import '../../mocks/accessibility_data_mock.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  setUp(() async {});

  testWidgets(
    '(1) Should be able to retrieve the Accessibility Localizations instance. (2) Should be able to run the translate method. (3) Should be able to run the translate method',
    (tester) async {
      // arrange
      const tKey = 'landing-page';
      const tApp = _BuildMaterialApp();
      await tester.pumpWidget(tApp);
      await tester.pumpAndSettle();
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      final localization =
          AccessibilityLocalizations.of(navigatorKey.currentContext!)!;

      final tA11YCatbreeds = A11YCatbreeds.fromJson(AccessibilityDataMock.json);

      // act (1)
      final result1 =
          AccessibilityLocalizations.of(navigatorKey.currentContext!);

      // act (2)
      final result2 = localization.translate(tKey);

      // act (3)
      final result3 = localization.getJsonTranslate();

      // assert (1)
      expect(result1, isA<AccessibilityLocalizations>());

      // assert (2)
      expect(localization, isA<AccessibilityLocalizations>());
      expect(result2, isA<Map>());
      expect(result2, AccessibilityDataMock.json[tKey]);

      // assert (3)
      expect(localization, isA<AccessibilityLocalizations>());
      expect(result3, isA<A11YCatbreeds>());
      expect(result3, tA11YCatbreeds);
    },
  );
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        AccessibilityLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('es'),
        Locale('en'),
      ],
      locale: const Locale('en'),
      home: Builder(
        builder: (context) {
          return Placeholder(
            key: navigatorKey,
          );
        },
      ),
      theme: ThemeData.light(),
    );
  }
}
