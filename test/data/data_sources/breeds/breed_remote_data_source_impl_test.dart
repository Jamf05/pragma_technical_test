import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/core/http/dio_http_client.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source_impl.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';

void main() {
  late Dio dioClient;
  late DioAdapter mockDioClient;
  late BreedRemoteDataSourceImpl dataSource;

  setUp(() async {
    await Env.load(fileName: AssetsToken.env.test.aEnv);
    dioClient = DioHttpClient();
    mockDioClient =
        DioAdapter(dio: dioClient, matcher: const UrlRequestMatcher());
    dataSource = BreedRemoteDataSourceImpl(client: dioClient);
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
      'should return the list of breed when the response code is 200',
      () async {
        mockDioClient.onGet(
          '/breeds',
          (server) => server.reply(
            200,
            tBreedRawData,
            delay: const Duration(seconds: 1),
          ),
          queryParameters: {
            'page': tPage,
            'limit': tLimit,
          },
        );

        // act
        final result = await dataSource.getBreeds(page: tPage, limit: tLimit);

        // assert
        expect(result, equals(tBreedList));
      },
    );

    test('should return a failed response', () async {
      // arrange
      final tResult = DioException(requestOptions: RequestOptions());

      mockDioClient.onGet(
        '/breeds',
        (server) => server.throws(0, tResult),
        queryParameters: {
          'page': tPage,
          'limit': tLimit,
        },
      );
      // act
      Object? actual;
      try {
        await dataSource.getBreeds(page: tPage, limit: tLimit);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, equals(DioFailure.decode(tResult)));
    });

    test('should return error because the data is not a List', () async {
      const tExceptionMessage = 'FormatException: Data is not a List';
      mockDioClient.onGet(
        '/breeds',
        (server) => server.reply(
          200,
          {},
          delay: const Duration(seconds: 1),
        ),
        queryParameters: {
          'page': tPage,
          'limit': tLimit,
        },
      );

      // act
      Object? actual;
      try {
        await dataSource.getBreeds(page: tPage, limit: tLimit);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, isA<ExceptionFailure>());
      expect((actual as ExceptionFailure).error, isA<FormatException>());
      expect(actual.message, equals(tExceptionMessage));
    });
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
      'should return the list of breed when the response code is 200',
      () async {
        mockDioClient.onGet(
          '/breeds/search',
          (server) => server.reply(
            200,
            tBreedRawData,
            delay: const Duration(seconds: 1),
          ),
          queryParameters: {
            'q': tQuery,
            'attach_image': tAttachImage,
          },
        );

        // act
        final result =
            await dataSource.search(query: tQuery, attachImage: tAttachImage);

        // assert
        expect(result, equals(tBreedList));
      },
    );

    test('should return a failed response', () async {
      // arrange
      final tResult = DioException(requestOptions: RequestOptions());

      mockDioClient.onGet(
        '/breeds/search',
        (server) => server.throws(0, tResult),
        queryParameters: {
          'q': tQuery,
          'attach_image': tAttachImage,
        },
      );
      // act
      Object? actual;
      try {
        await dataSource.search(query: tQuery, attachImage: tAttachImage);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, equals(DioFailure.decode(tResult)));
    });

    test('should return error because the data is not a List', () async {
      const tExceptionMessage = 'FormatException: Data is not a List';
      mockDioClient.onGet(
        '/breeds/search',
        (server) => server.reply(
          200,
          {},
          delay: const Duration(seconds: 1),
        ),
        queryParameters: {
          'q': tQuery,
          'attach_image': tAttachImage,
        },
      );

      // act
      Object? actual;
      try {
        await dataSource.search(query: tQuery, attachImage: tAttachImage);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, isA<ExceptionFailure>());
      expect((actual as ExceptionFailure).error, isA<FormatException>());
      expect(actual.message, equals(tExceptionMessage));
    });
  });

  group('Method getImage', () {
    const String tReferenceImageId = 'vJ3lEYgXr';
    final Map<String, dynamic> tImageBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.imageBreedJson),
    );
    final ImageBreedModel tBreedList =
        ImageBreedModel.fromJson(tImageBreedRawData);

    test(
      'should return the image breed when the response code is 200',
      () async {
        mockDioClient.onGet(
          '/images/$tReferenceImageId',
          (server) => server.reply(
            200,
            tImageBreedRawData,
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        final result = await dataSource.getImage(tReferenceImageId);

        // assert
        expect(result, equals(tBreedList));
      },
    );

    test('should return a failed response', () async {
      // arrange
      final tResult = DioException(requestOptions: RequestOptions());

      mockDioClient.onGet(
        '/images/$tReferenceImageId',
        (server) => server.throws(0, tResult),
      );
      // act
      Object? actual;
      try {
        await dataSource.getImage(tReferenceImageId);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, equals(DioFailure.decode(tResult)));
    });

    test('should return error because the data is not a Map', () async {
      const tExceptionMessage = 'FormatException: Data is not a Map';
      mockDioClient.onGet(
        '/images/$tReferenceImageId',
        (server) => server.reply(
          200,
          [],
          delay: const Duration(seconds: 1),
        ),
      );

      // act
      Object? actual;
      try {
        await dataSource.getImage(tReferenceImageId);
      } catch (e) {
        actual = e;
      }
      // assert
      expect(actual, isA<ExceptionFailure>());
      expect((actual as ExceptionFailure).error, isA<FormatException>());
      expect(actual.message, equals(tExceptionMessage));
    });
  });
}
