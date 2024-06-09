import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';
import 'package:pragma_technical_test/domain/use_cases/get_image_breed_use_case.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import 'get_image_breed_use_case_test.mocks.dart';

@GenerateMocks([BreedRepository])
void main() {
  late MockBreedRepository mockBreedRepository;
  late GetImageBreedUseCase useCase;

  setUp(() {
    mockBreedRepository = MockBreedRepository();
    useCase = GetImageBreedUseCase(repository: mockBreedRepository);
  });

  group('Method', () {
    const String tReferenceImageId = 'vJ3lEYgXr';
    final Map<String, dynamic> tImageBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.imageBreedJson),
    );
    final ImageBreedModel tImageBreed =
        ImageBreedModel.fromJson(tImageBreedRawData);

    test(
        'should return a ImageBreedEntity when the call to remote data source is successful',
        () async {
      // arrange
      when(mockBreedRepository.getImage(tReferenceImageId))
          .thenAnswer((_) async => Right(tImageBreed));
      // act
      final result = await useCase.call(tReferenceImageId);
      // assert
      verify(mockBreedRepository.getImage(tReferenceImageId));
      expect(result, isA<Right>());
      expect(result, Right(tImageBreed));
    });

    test(
        'should return dio failure when a call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockBreedRepository.getImage(tReferenceImageId)).thenAnswer(
          (_) async => Left(DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: '')))));

      // act
      final result = await useCase.call(tReferenceImageId);

      // assert
      expect(
          Left(DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: '')))),
          equals(result));
    });
  });
}
