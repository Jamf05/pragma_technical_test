// ignore_for_file: discarded_futures

import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:pragma_technical_test/core/validators/query_input.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/domain/use_cases/get_breeds_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/get_image_breed_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/search_breeds_use_case.dart';
import 'package:pragma_technical_test/presentation/android/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import 'landing_cubit_test.mocks.dart';

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
  setUp(() {
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
  });

  group('Method setQuery', () {
    const String tQuery = 'air';
    const tQueryInput = QueryInput.dirty(value: tQuery);
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
  });
}
