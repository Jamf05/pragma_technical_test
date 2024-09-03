import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/provider/theme_provider.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

class MockSplashCubit extends MockCubit<SplashState> implements SplashCubit {}

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

void main() {
  late ThemeProvider tThemeProvider;
  late SplashCubit mockCubit;

  late LandingCubit mockLandingCubit;
  late TextEditingController tQueryController;
  late ScrollController tScrollController;

  const tSplashCatbreedsKey = Key('ptt_splash_catbreeds_key');

  setUp(() async {
    tThemeProvider = ThemeProvider();
    mockCubit = MockSplashCubit();

    mockLandingCubit = MockLandingCubit();
    tQueryController = TextEditingController();
    tScrollController = ScrollController();
  });

  testWidgets('SplashPage when cubit state is SplashInitial', (tester) async {
    // arrange
    const tIllustrationKey = Key('ptt_splash_cat_illustration_key');
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      mockLandingCubit: mockLandingCubit,
      tThemeProvider: tThemeProvider,
    );

    when(() => mockCubit.state).thenReturn(SplashInitial());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.text('Catbreeds'), findsOneWidget);
    expect(find.byKey(tIllustrationKey), findsOneWidget);
  });

  testWidgets('SplashPage when cubit state is SplashLoaded', (tester) async {
    // arrange
    const tIllustrationKey = Key('ptt_splash_cat_illustration_key');
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      mockLandingCubit: mockLandingCubit,
      tThemeProvider: tThemeProvider,
    );

    whenListen<SplashState>(
      mockCubit,
      Stream<SplashState>.fromIterable([SplashInitial(), SplashLoaded()]),
      initialState: SplashInitial(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    when(() => mockLandingCubit.state).thenReturn(LandingInitial());

    // act
    await tester.pumpWidget(tApp);
    await tester.pumpAndSettle();

    // assert
    expect(find.byKey(tSplashCatbreedsKey), findsNothing);
    expect(find.byKey(tIllustrationKey), findsNothing);
    expect(find.byType(SplashPage), findsNothing);
    expect(find.byType(LandingPage), findsOneWidget);
  });
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp({
    required this.mockCubit,
    required this.mockLandingCubit,
    required this.tThemeProvider,
  });

  final SplashCubit mockCubit;
  final LandingCubit mockLandingCubit;
  final ThemeProvider tThemeProvider;

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
      home: BlocProvider<SplashCubit>(
        create: (BuildContext context) => mockCubit,
        child: const SplashPage(),
      ),
      routes: <String, WidgetBuilder>{
        LandingPage.route: (BuildContext context) => BlocProvider<LandingCubit>(
              create: (BuildContext context) => mockLandingCubit,
              child: const LandingPage(),
            ),
      },
      theme: tThemeProvider.selected,
    );
  }
}
