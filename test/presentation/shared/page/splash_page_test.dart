import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/presentation/provider/theme_provider.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

class MockSplashCubit extends MockCubit<SplashState> implements SplashCubit {}

void main() {
  late ThemeProvider tThemeProvider;
  late SplashCubit mockSplashCubit;
  late SplashState tState;

  setUp(() async {
    tThemeProvider = ThemeProvider();
    mockSplashCubit = MockSplashCubit();
    tState = SplashInitial();
  });

  testWidgets('SplashPage ...', (tester) async {
    // arrange
    final tApp = MaterialApp(
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
      home: BlocProvider<SplashCubit>(
        create: (BuildContext context) => mockSplashCubit,
        child: const SplashPage(),
      ),
      theme: tThemeProvider.selected,
    );

    whenListen<SplashState>(
      mockSplashCubit,
      Stream<SplashState>.fromIterable([tState]),
      initialState: tState,
    );

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.text('Catbreeds'), findsOneWidget);
  });
}
