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

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

void main() {
  late ThemeProvider tThemeProvider;
  late LandingCubit mockCubit;
  late TextEditingController tQueryController;
  late ScrollController tScrollController;

  const tLandingAppBarKey = Key('ptt_landing_app_bar_key');
  const tLandingLoadingKey = Key('ptt_landing_loading_key');

  setUp(() async {
    tThemeProvider = ThemeProvider();
    mockCubit = MockLandingCubit();
    tQueryController = TextEditingController();
    tScrollController = ScrollController();
  });

  testWidgets('LandingPage when cubit state is LandingInitial', (tester) async {
    // arrange
    const tLandingAppBarKey = Key('ptt_landing_app_bar_key');
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(const []);

    when(() => mockCubit.state).thenReturn(LandingInitial());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsNothing);
  });

  testWidgets('LandingPage when cubit state is LandingInitialLoading',
      (tester) async {
    // arrange
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(const []);

    when(() => mockCubit.state).thenReturn(LandingInitialLoading());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsOneWidget);
  });
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp({
    required this.mockCubit,
    required this.tThemeProvider,
  });

  final LandingCubit mockCubit;
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
      home: BlocProvider<LandingCubit>(
        create: (BuildContext context) => mockCubit,
        child: const LandingPage(),
      ),
      theme: tThemeProvider.selected,
    );
  }
}
