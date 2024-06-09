import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/core/http/dio_http_client.dart';
import 'package:pragma_technical_test/data/data_sources/breed_remote_data_source.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  late Dio dioClient;
  late DioAdapter mockDioClient;
  late BreedRemoteDataSourceImpl dataSource;

  setUp(() async {
    await Env.load(fileName: AssetsToken.env.aEnvProd);
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
  });
}
