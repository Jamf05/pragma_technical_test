// ignore_for_file: discarded_futures

import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';

import 'package:pragma_technical_test/core/validators/query_input.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/domain/use_cases/get_breeds_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/get_image_breed_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/search_breeds_use_case.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/theme_cubit/theme_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../mocks/mock_cache_manager.dart';
import 'landing_cubit_test.mocks.dart';

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

class MockCacheManagerCubit extends MockCubit<BaseCacheManager>
    implements CacheManagerCubit {
  MockCacheManagerCubit() : super();

  @override
  BaseCacheManager state = MockCacheManager();
}

@GenerateMocks([
  GetBreedsUseCase,
  SearchBreedsUseCase,
  GetImageBreedUseCase,
])
void main() {
  late LandingCubit cubit;
  final mockGetBreedsUseCase = MockGetBreedsUseCase();
  final mockSearchBreedsUseCase = MockSearchBreedsUseCase();
  final mockGetImageBreedUseCase = MockGetImageBreedUseCase();

  late ThemeCubit tThemeCubit;
  late CacheManagerCubit mockCacheManagerCubit;

  const tEmptyInput = QueryInput.dirty(value: '');
  const tListViewKey = Key('ptt_list_view_key');

  setUp(() async {
    await Env.load(fileName: AssetsToken.env.aEnvDev);
    tThemeCubit = ThemeCubit();
    mockCacheManagerCubit = MockCacheManagerCubit();
    cubit = LandingCubit(
      getBreedsUseCase: mockGetBreedsUseCase,
      searchBreedsUseCase: mockSearchBreedsUseCase,
      getImageBreedUseCase: mockGetImageBreedUseCase,
    );
  });

  test(
    'initial state should be empty',
    () {
      expect(cubit.state, LandingInitial());
    },
  );

  group('Method init', () {
    const int tPage = 0;
    const int tLimit = 10;

    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();
    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when function is added.',
      build: () {
        when(mockGetBreedsUseCase.call(tPage, tLimit))
            .thenAnswer((_) async => Right(tBreedList));
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        verify(mockGetBreedsUseCase.call(tPage, tLimit));
        expect(cubit.breeds, tBreedList);
      },
    );

    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingError] when function is added.',
      build: () {
        when(mockGetBreedsUseCase.call(tPage, tLimit)).thenAnswer((_) async =>
            Left(ExceptionFailure.decode(Exception('This is a test error'))));
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        const LandingError('Exception: This is a test error'),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        verify(mockGetBreedsUseCase.call(tPage, tLimit));
        expect(cubit.breeds, []);
      },
    );
  });

  group('Method setQuery', () {
    const String tQuery = 'air';
    const tQueryInput = QueryInput.dirty(value: tQuery);
    const tQueryInputEmpty = QueryInput.dirty(value: '');
    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsSearchJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();
    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when function is added.',
      build: () {
        when(mockSearchBreedsUseCase.call(tQuery, null))
            .thenAnswer((_) async => Right(tBreedList));
        return cubit;
      },
      act: (cubit) => cubit.setQuery(tQuery),
      wait: const Duration(seconds: 1),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        verify(mockSearchBreedsUseCase.call(tQuery, null));
        expect(cubit.query, tQueryInput);
        expect(cubit.breeds, tBreedList);
      },
    );
  });

  testWidgets('Method setQuery with scrollController jumpTo', (tester) async {
    // arrange
    final tApp = _BuildApp(
      landingCubit: cubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    when(mockGetBreedsUseCase.call(0, 10))
        .thenAnswer((_) async => const Right([]));

    // act
    await tester.pumpWidget(tApp);

    cubit.setQuery('');

    await tester.pump(const Duration(seconds: 1));

    // assert
    expect(cubit.query, equals(tEmptyInput));
    expect(cubit.breeds, []);
    verify(mockGetBreedsUseCase.call(0, 10));
  });

  group('Method onRefresh', () {
    const int tPage = 0;
    const int tLimit = 10;
    const tQueryInput = QueryInput.pure();
    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();
    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when function is added.',
      build: () {
        when(mockGetBreedsUseCase.call(tPage, tLimit))
            .thenAnswer((_) async => Right(tBreedList));
        return cubit;
      },
      act: (cubit) => cubit.onRefresh(),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        verify(mockGetBreedsUseCase.call(tPage, tLimit));
        expect(cubit.breeds, tBreedList);
        expect(cubit.query, tQueryInput);
      },
    );
  });

  group('Method onSearch', () {
    const tQueryInput = QueryInput.pure();
    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when function is added and the query is empty.',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.onSearch(),
      wait: const Duration(seconds: 1),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        expect(cubit.query, tQueryInput);
        expect(cubit.breeds, []);
      },
    );
  });

  group('Method clearInput', () {
    const tQueryInput = QueryInput.pure();
    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when function is added.',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.clearInput(),
      wait: const Duration(seconds: 1),
      expect: () => <LandingState>[
        LandingInitialLoading(),
        LandingInitialLoaded(),
      ],
      verify: (cubit) {
        expect(cubit.query, tQueryInput);
        expect(cubit.queryController.text, equals(''));
      },
    );
  });

  group('Method imageStream', () {
    const String tReferenceImageId = 'vJ3lEYgXr';
    final Map<String, dynamic> tImageBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.imageBreedJson),
    );
    final ImageBreedModel tImageBreed =
        ImageBreedModel.fromJson(tImageBreedRawData);

    final Map<String, StreamController<ImageBreedEntity>> tImageControllers =
        {};
    tImageControllers[tReferenceImageId] = BehaviorSubject();
    tImageControllers[tReferenceImageId]!.add(tImageBreed);

    late Stream<ImageBreedEntity> actualStream;

    blocTest<LandingCubit, LandingState>(
      'emits [LandingInitialLoading, LandingInitialLoaded] when MyEvent is added.',
      build: () {
        when(mockGetImageBreedUseCase.call(tReferenceImageId))
            .thenAnswer((_) async => Right(tImageBreed));
        return cubit;
      },
      act: (cubit) {
        actualStream = cubit.imageStream(tReferenceImageId);
        return actualStream;
      },
      wait: const Duration(seconds: 2),
      expect: () => <LandingState>[],
      verify: (cubit) {
        verify(mockGetImageBreedUseCase.call(tReferenceImageId));
        expect(
            cubit.imageControllers[tReferenceImageId], isA<BehaviorSubject>());
        expect(cubit.imageControllers.length, tImageControllers.length);
        expect(actualStream, emits(tImageBreed));
      },
    );

    test('Property ScrollController', () {
      expect(cubit.scrollController, isA<ScrollController>());
    });

    blocTest<LandingCubit, LandingState>(
      'Should return empty when call addListener function.',
      build: () {
        return cubit;
      },
      act: (cubit) {
        return cubit..addListener();
      },
      wait: const Duration(seconds: 2),
      expect: () => <LandingState>[],
      verify: (cubit) {},
    );
  });

  testWidgets(
      'LandingPage when cubit state is LandingInitialLoaded and one element in list',
      (tester) async {
    // arrange
    final tApp = _BuildApp(
      landingCubit: cubit,
      mockThemeCubit: tThemeCubit,
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: const _BuildMaterialApp(),
    );

    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();

    final BreedModel tLast = tBreedList.last;

    final tItemCatBreedCardLastKey =
        Key('ptt_item_cat_breed_card_${tLast.id!}_key');

    when(mockGetBreedsUseCase.call(0, 10))
        .thenAnswer((_) async => Right(tBreedList));
    
    when(mockGetBreedsUseCase.call(1, 10))
        .thenAnswer((_) async => const Right([]));

    for (final breed in tBreedList) {
      when(mockGetImageBreedUseCase.call(breed.referenceImageId))
          .thenAnswer((_) async => Right(ImageBreedModel(
                id: breed.referenceImageId,
                url: '',
              )));
    }

    // act
    await tester.pumpWidget(tApp);
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final listFinder = find.descendant(
      of: find.byKey(tListViewKey),
      matching: find.byType(Scrollable),
    );

    final itemFinder = find.byKey(tItemCatBreedCardLastKey);

    await tester.scrollUntilVisible(
      itemFinder,
      1600,
      scrollable: listFinder,
    );

    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    // assert
    expect(find.byKey(tItemCatBreedCardLastKey), findsOneWidget);
    verify(mockGetBreedsUseCase.call(0, 10));
    verify(mockGetBreedsUseCase.call(1, 10));
    for (final breed in tBreedList) {
      verify(mockGetImageBreedUseCase.call(breed.referenceImageId));
    }
  });
}

class _BuildApp extends StatelessWidget {
  final CacheManagerCubit mockCacheManagerCubit;
  final LandingCubit landingCubit;
  final ThemeCubit mockThemeCubit;
  final Widget child;

  const _BuildApp({
    required this.child,
    required this.mockCacheManagerCubit,
    required this.landingCubit,
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
          create: (BuildContext context) => landingCubit,
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
          home: const LandingPage(),
          theme: state,
        );
      },
    );
  }
}
