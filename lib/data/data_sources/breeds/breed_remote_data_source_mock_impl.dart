import 'package:pragma_technical_test/core/error_handling/error.dart';
import 'package:pragma_technical_test/core/error_handling/exception.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source.dart';
import 'package:pragma_technical_test/data/mocks/breeds_mock.dart';
import 'package:pragma_technical_test/data/mocks/image_breed_mock.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

class BreedRemoteDataSourceMockImpl implements BreedRemoteDataSource {

  BreedRemoteDataSourceMockImpl();
  @override
  Future<List<BreedModel>> getBreeds(
      {required int page, int? limit = 10}) async {
    try {
      if (page == 0) {
        return breedsMockPage0;
      } else if (page == 1) {
        return breedsMockPage1;
      }
      return [];
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
      return breedsMockPage0;
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<ImageBreedModel> getImage(String referenceImageId) async {
    try {
      return imageBreedMock;
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
