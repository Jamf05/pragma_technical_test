import 'package:dio/dio.dart';
import 'package:pragma_technical_test/core/error_handling/error.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

abstract class BreedRemoteDataSource {
  Future<List<BreedModel>> getBreeds({required int page, int? limit});
  Future<List<BreedModel>> search({required String query, int? attachImage});
  Future<ImageBreedModel> getImage(String referenceImageId);
}

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
      return ((response.data ?? []) as List)
          .map((e) => BreedModel.fromJson(e))
          .toList();
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
      return ((response.data ?? []) as List)
          .map((e) => BreedModel.fromJson(e))
          .toList();
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
      return ImageBreedModel.fromJson(response.data ?? {});
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
