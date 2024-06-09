import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';
import 'package:pragma_technical_test/domain/use_cases/search_breeds_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import 'search_breeds_use_case_test.mocks.dart';

@GenerateMocks([BreedRepository])
void main() {
  late MockBreedRepository mockBreedRepository;
  late SearchBreedsUseCase useCase;

  setUp(() {
    mockBreedRepository = MockBreedRepository();
    useCase = SearchBreedsUseCase(repository: mockBreedRepository);
  });

  group('Method', () {
    const String tQuery = 'air';
    const int tAttachImage = 1;
    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsSearchJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();
    test(
        'should return a list of Breed when the call to remote data source is successful',
        () async {
      // arrange
      when(mockBreedRepository.search(query: tQuery, attachImage: tAttachImage))
          .thenAnswer((_) async => Right(tBreedList));
      // act
      final result = await useCase.call(tQuery, tAttachImage);
      // assert
      verify(
          mockBreedRepository.search(query: tQuery, attachImage: tAttachImage));
      expect(result, isA<Right>());
      expect(result, Right(tBreedList));
    });

    test(
      'should return dio failure when a call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockBreedRepository.search(
                query: tQuery, attachImage: tAttachImage))
            .thenAnswer((_) async => Left(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: '')))));

        // act
        final result = await useCase.call(tQuery, tAttachImage);

        // assert
        expect(
            Left(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: '')))),
            equals(result));
      },
    );
  });
}
