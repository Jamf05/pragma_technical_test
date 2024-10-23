import 'package:dio/dio.dart';
import 'package:pragma_technical_test/core/error_handling/error.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

class BreedRemoteDataSourceImpl implements BreedRemoteDataSource {
  final Dio client;

  BreedRemoteDataSourceImpl({required this.client});
  @override
  Future<List<BreedModel>> getBreeds(
      {required int page, int? limit = 10}) async {
    try {
      final response = await client.get(
        '/breeds',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.data is List) {
        return (response.data as List)
            .map((e) => BreedModel.fromJson(e))
            .toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<BreedModel>> search(
      {required String query, int? attachImage = 1}) async {
    try {
      final response = await client.get(
        '/breeds/search',
        queryParameters: {
          'q': query,
          'attach_image': attachImage,
        },
      );

      if (response.data is List) {
        return (response.data as List)
            .map((e) => BreedModel.fromJson(e))
            .toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<ImageBreedModel> getImage(String referenceImageId) async {
    try {
      final response = await client.get('/images/$referenceImageId');
      if (response.data is Map) {
        return ImageBreedModel.fromJson(response.data);
      } else {
        throw const FormatException('Data is not a Map');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
