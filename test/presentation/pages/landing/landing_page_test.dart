import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';

import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/theme_cubit/theme_cubit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pragma_technical_test/dependency_injection.dart' as di;

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';
import '../../../mocks/accessibility_data_mock.dart';
import '../../../mocks/mock_cache_manager.dart';

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

class MockCacheManagerCubit extends MockCubit<BaseCacheManager>
    implements CacheManagerCubit {
  MockCacheManagerCubit() : super();

  @override
  BaseCacheManager state = MockCacheManager();
}

void main() {
  late ThemeCubit tThemeCubit;
  late LandingCubit mockLandingCubit;
  late CacheManagerCubit mockCacheManagerCubit;
  late TextEditingController tQueryController;
  late ScrollController tScrollController;

  const tLandingAppBarKey = Key('ptt_landing_app_bar_key');
  const tLandingLoadingKey = Key('ptt_landing_loading_key');
  const landingErrorKey = Key('ptt_landing_error_key');
  const tListViewKey = Key('ptt_list_view_key');
  const tLandingThemeButtonKey = Key('ptt_landing_theme_button_key');
  const tSearchButtonKey = Key('ptt_search_button_key');

  final Map<String, StreamController<ImageBreedEntity>> tImageControllers = {};

  setUpAll(() async {
    await Env.load(fileName: AssetsToken.env.test.aEnv);
    await di.init();
    tThemeCubit = ThemeCubit();
    mockLandingCubit = MockLandingCubit();
    mockCacheManagerCubit = MockCacheManagerCubit();
    tQueryController = TextEditingController();
    tScrollController = ScrollController();
  });

  List<Stream<ImageBreedEntity>> buildImageStreamList(List<BreedModel> breeds,
      Map<String, StreamController<ImageBreedEntity>> controllers) {
    return breeds.map((breed) {
      // ignore: close_sinks
      final StreamController<ImageBreedEntity> controller = BehaviorSubject();
      controllers[breed.referenceImageId!] = controller;
      return controller.stream;
    }).toList();
  }

  Future<void> disposeImageStreamList(
      Map<String, StreamController<ImageBreedEntity>> controllers) async {
    for (final controller in controllers.values) {
      await controller.close();
    }
    controllers.clear();
  }

  tearDownAll(() async {
    tQueryController.dispose();
    tScrollController.dispose();
    await disposeImageStreamList(tImageControllers);
  });

  testWidgets('LandingPage when cubit state is LandingInitial', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    when(() => mockLandingCubit.state).thenReturn(LandingInitial());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsNothing);
  });

  testWidgets('LandingPage when cubit state is LandingInitialLoading',
      (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoading());

    // act
    await tester.pumpWidget(tApp);

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsOneWidget);
  });

  testWidgets(
      'LandingPage when cubit state is LandingInitialLoaded and one element in list',
      (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();

    final BreedModel tFrist = tBreedList.first;
    final BreedModel tLast = tBreedList.last;

    final ImageBreedModel tImageBreedModel = ImageBreedModel(
      id: tFrist.id,
      url: 'https://cdn2.thecatapi.com/images/${tFrist.id}.jpg',
    );

    final tItemCatBreedCardFirstKey =
        Key('ptt_item_cat_breed_card_${tFrist.id!}_key');
    final tItemCatBreedCardLastKey =
        Key('ptt_item_cat_breed_card_${tLast.id!}_key');

    final tImageStreamList =
        buildImageStreamList(tBreedList, tImageControllers);

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(tBreedList);

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    for (int i = 0; i < tBreedList.length; i++) {
      when(() => mockLandingCubit.imageStream(tBreedList[i].referenceImageId))
          .thenAnswer((_) {
        return tImageStreamList[i];
      });
    }

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    // act
    await tester.pumpWidget(tApp);
    tImageControllers[tFrist.referenceImageId]!.add(tImageBreedModel);
    await tester.pump();

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsNothing);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byKey(tItemCatBreedCardFirstKey), findsOneWidget);

    // act
    final listFinder = find.byKey(tListViewKey);
    final itemFinder = find.byKey(tItemCatBreedCardLastKey);

    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      const Offset(0, -800),
    );

    // assert
    expect(itemFinder, findsOneWidget);
  });

  testWidgets('LandingPage when cubit state is LandingError', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    const tLandingError = LandingError('Error');

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    whenListen<LandingState>(
      mockLandingCubit,
      Stream<LandingState>.fromIterable(
          [LandingInitial(), LandingInitialLoading(), tLandingError]),
      initialState: LandingInitial(),
    );

    // act
    await tester.pumpWidget(tApp);
    await tester.pump();

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsOneWidget);
    expect(find.byKey(landingErrorKey), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('Should be able to change the theme icon', (tester) async {
    // arrance

    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    // act
    await tester.pumpWidget(tApp);
    await tester.pumpAndSettle();

    // assert
    expect(find.byKey(tLandingThemeButtonKey), findsOneWidget);
    expect(find.byIcon(Icons.nightlight_round), findsOneWidget);

    /// act
    final themeButtonFinder = find.byKey(tLandingThemeButtonKey);

    await tester.tap(themeButtonFinder);
    await tester.pumpAndSettle();

    // assert
    expect(themeButtonFinder, findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);

    /// act
    await tester.tap(themeButtonFinder);
    await tester.pumpAndSettle();

    // assert
    expect(themeButtonFinder, findsOneWidget);
    expect(find.byIcon(Icons.nightlight_round), findsOneWidget);
  });

  testWidgets('Should be called onTapOutside', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    // act
    await tester.pumpWidget(tApp);
    await tester.pump();

    await tester.tap(find.byType(TextField));
    await tester.pump();
    await tester.tap(find.byKey(tLandingAppBarKey));
    await tester.pump();

    // assert
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
  });

  testWidgets('Should be called setQuery', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);
    when(() => mockLandingCubit.setQuery('test1')).thenReturn(null);

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    // act.
    await tester.pumpWidget(tApp);
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'test1');
    await tester.pump();

    // assert
    expect(find.byType(TextField), findsOneWidget);
    verify(() => mockLandingCubit.setQuery('test1')).called(1);
  });

  testWidgets('Should be called search button', (tester) async {
    // arrange
    final tApp = _BuildApp(
      mockLandingCubit: mockLandingCubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(() => mockLandingCubit.queryController).thenReturn(tQueryController);
    when(() => mockLandingCubit.scrollController).thenReturn(tScrollController);
    when(() => mockLandingCubit.breeds).thenReturn(const []);
    when(() => mockLandingCubit.setQuery('test2')).thenReturn(null);
    when(() => mockLandingCubit.onSearch()).thenAnswer((_) async {});

    when(() => mockLandingCubit.state).thenReturn(LandingInitialLoaded());

    // act
    await tester.pumpWidget(tApp);
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'test2');
    await tester.pump();
    await tester.tap(find.byKey(tSearchButtonKey));
    await tester.pump();

    // assert
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byKey(tSearchButtonKey), findsOneWidget);
    verify(() => mockLandingCubit.setQuery('test2')).called(1);
    verify(() => mockLandingCubit.onSearch()).called(1);
  });
}

class _BuildApp extends StatelessWidget {
  final CacheManagerCubit mockCacheManagerCubit;
  final LandingCubit mockLandingCubit;
  final ThemeCubit mockThemeCubit;
  final Widget child;

  const _BuildApp({
    required this.child,
    required this.mockCacheManagerCubit,
    required this.mockLandingCubit,
    required this.mockThemeCubit,
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
        BlocProvider<ThemeCubit>.value(
          value: mockThemeCubit,
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
    return BlocBuilder<ThemeCubit, ThemeData>(
      bloc: context.read<ThemeCubit>(),
      builder: (context, state) {
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
          home: LandingPage(
            a11YLandingPage: AccessibilityDataMock.a11YLandingPageMock,
          ),
          theme: state,
        );
      },
    );
  }
}
