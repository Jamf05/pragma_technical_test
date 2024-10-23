import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/data/repositories/breed_repository_impl.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import 'breed_repository_impl_test.mocks.dart';

@GenerateMocks([BreedRemoteDataSource])
void main() {
  late MockBreedRemoteDataSource mockBreedRemoteDataSource;
  late BreedRepositoryImpl repository;

  setUp(() {
    mockBreedRemoteDataSource = MockBreedRemoteDataSource();
    repository =
        BreedRepositoryImpl(remoteDataSource: mockBreedRemoteDataSource);
  });

  group('Method getBreeds', () {
    const int tPage = 0;
    const int tLimit = 10;

    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();
    test(
        'should return a list of Breed when the call to remote data source is successful',
        () async {
      // arrange
      when(mockBreedRemoteDataSource.getBreeds(page: tPage, limit: tLimit))
          .thenAnswer((_) async => tBreedList);
      // act
      final result = await repository.getBreeds(page: tPage, limit: tLimit);
      // assert
      verify(mockBreedRemoteDataSource.getBreeds(page: tPage, limit: tLimit));
      expect(result, isA<Right>());
      expect(result, Right(tBreedList));
    });

    test(
      'should return dio failure when a call to remote data source is unsuccessful',
      () async {
        // arrange

        when(mockBreedRemoteDataSource.getBreeds(page: tPage, limit: tLimit))
            .thenThrow(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: ''))));

        // act
        final result = await repository.getBreeds(page: tPage, limit: tLimit);

        // assert
        verify(mockBreedRemoteDataSource.getBreeds(page: tPage, limit: tLimit));
        expect(
            result,
            equals(Left(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: ''))))));
      },
    );
  });

  group('Method search', () {
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
      when(mockBreedRemoteDataSource.search(
              query: tQuery, attachImage: tAttachImage))
          .thenAnswer((_) async => tBreedList);
      // act
      final result =
          await repository.search(query: tQuery, attachImage: tAttachImage);
      // assert
      verify(mockBreedRemoteDataSource.search(
          query: tQuery, attachImage: tAttachImage));
      expect(result, isA<Right>());
      expect(result, Right(tBreedList));
    });

    test(
      'should return dio failure when a call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockBreedRemoteDataSource.search(
                query: tQuery, attachImage: tAttachImage))
            .thenThrow(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: ''))));

        // act
        final result =
            await repository.search(query: tQuery, attachImage: tAttachImage);

        // assert
        verify(mockBreedRemoteDataSource.search(
            query: tQuery, attachImage: tAttachImage));
        expect(
            result,
            equals(Left(DioFailure.decode(
                DioException(requestOptions: RequestOptions(path: ''))))));
      },
    );
  });

  group('Method getImage', () {
    const String tReferenceImageId = 'vJ3lEYgXr';
    final Map<String, dynamic> tImageBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.imageBreedJson),
    );
    final ImageBreedModel tImageBreed =
        ImageBreedModel.fromJson(tImageBreedRawData);

    test(
      'should return the image breed when the response code is 200',
      () async {
        // arrange
        when(mockBreedRemoteDataSource.getImage(tReferenceImageId))
            .thenAnswer((_) async => tImageBreed);
        // act
        final result = await repository.getImage(tReferenceImageId);
        // assert
        verify(mockBreedRemoteDataSource.getImage(tReferenceImageId));
        expect(result, isA<Right>());
        expect(result, Right(tImageBreed));
      },
    );

    test('should return a failed response', () async {
      // arrange
      when(mockBreedRemoteDataSource.getImage(tReferenceImageId)).thenThrow(
          DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: ''))));

      // act
      final result = await repository.getImage(tReferenceImageId);

      // assert
      verify(mockBreedRemoteDataSource.getImage(tReferenceImageId));
      expect(
          result,
          equals(Left(DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: ''))))));
    });
  });
}
