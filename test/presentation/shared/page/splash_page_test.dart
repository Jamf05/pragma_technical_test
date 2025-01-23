import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

import '../../../mocks/accessibility_data_mock.dart';
import '../../../mocks/mock_cache_manager.dart';

class MockSplashCubit extends MockCubit<SplashState> implements SplashCubit {}

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

class MockCacheManagerCubit extends MockCubit<BaseCacheManager>
    implements CacheManagerCubit {
  MockCacheManagerCubit() : super();

  @override
  BaseCacheManager state = MockCacheManager();
}

void main() {
  late SplashCubit mockSplashCubit;
  late LandingCubit mockLandingCubit;
  late CacheManagerCubit mockCacheManagerCubit;

  late TextEditingController tQueryController;
  late ScrollController tScrollController;

  const tSplashCatbreedsKey = Key('ptt_splash_catbreeds_key');
  const tIllustrationKey = Key('ptt_splash_cat_illustration_key');

  setUp(() async {
    mockSplashCubit = MockSplashCubit();
    mockLandingCubit = MockLandingCubit();
    mockCacheManagerCubit = MockCacheManagerCubit();

    tQueryController = TextEditingController();
    tScrollController = ScrollController();
  });

  testWidgets('SplashPage when cubit state is SplashInitial', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockCacheManagerCubit: mockCacheManagerCubit,
      mockLandingCubit: mockLandingCubit,
      mockSplashCubit: mockSplashCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockSplashCubit.state).thenReturn(SplashInitial());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.text('Catbreeds'), findsOneWidget);
    expect(find.byKey(tIllustrationKey), findsOneWidget);
  });

  testWidgets('SplashPage when cubit state is SplashLoaded', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockCacheManagerCubit: mockCacheManagerCubit,
      mockLandingCubit: mockLandingCubit,
      mockSplashCubit: mockSplashCubit,
      child: const _BuildMaterialApp(),
    );

    whenListen<SplashState>(
      mockSplashCubit,
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

class _BuildApp extends StatelessWidget {
  final Widget child;
  final CacheManagerCubit mockCacheManagerCubit;
  final LandingCubit mockLandingCubit;
  final SplashCubit mockSplashCubit;

  const _BuildApp({
    required this.child,
    required this.mockCacheManagerCubit,
    required this.mockLandingCubit,
    required this.mockSplashCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CacheManagerCubit>(
          create: (BuildContext context) => mockCacheManagerCubit,
        ),
        BlocProvider<LandingCubit>(
          create: (BuildContext context) => mockLandingCubit,
        ),
        BlocProvider<SplashCubit>(
          create: (BuildContext context) => mockSplashCubit,
        ),
      ],
      child: child,
    );
  }
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

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
      home: const SplashPage(),
      routes: <String, WidgetBuilder>{
        LandingPage.route: (BuildContext context) => LandingPage(
              a11YLandingPage: AccessibilityDataMock.a11YLandingPageMock,
            ),
      },
      theme: ThemeFoundation.light,
    );
  }
}
