import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';

void main() {
  testWidgets('Should return a ErrorInNetworkImageWidget', (WidgetTester tester) async {
    // arrange
    const app = _App();
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(ErrorInNetworkImageWidget), findsOneWidget);
  });
}

class _App extends StatelessWidget {

  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ErrorInNetworkImageWidget()],
        ),
      ),
      theme: ThemeFoundation.light,
    );
  }
}
