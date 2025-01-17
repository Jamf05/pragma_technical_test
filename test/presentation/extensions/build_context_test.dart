import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/core/utils/custom_overlays.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  testWidgets('Should be able to see all extensions', (tester) async {
    // arrange
    const app = _BuildMaterialApp();
    // act
    await tester.pumpWidget(app);
    final context = navigatorKey.currentContext!;
    // assert
    expect(context.mediaQuerySize, isA<Size>());
    expect(context.theme, isA<ThemeData>());
    expect(context.focus, isA<FocusScopeNode>());
    expect(context.navigator, isA<NavigatorState>());
    expect(context.isBrightnessDark, isA<bool>());
    expect(context.brightness, isA<Brightness>());
    expect(context.overlay, isA<CustomOverlays>());
    expect(context.l10n, isA<AppLocalizations>());
  });
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('es'),
        Locale('en'),
      ],
      home: const Placeholder(),
      theme: ThemeData.light(),
    );
  }
}
