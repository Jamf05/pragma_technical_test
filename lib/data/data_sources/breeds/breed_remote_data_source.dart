import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

abstract class BreedRemoteDataSource {
  Future<List<BreedModel>> getBreeds({required int page, int? limit});
  Future<List<BreedModel>> search({required String query, int? attachImage});
  Future<ImageBreedModel> getImage(String referenceImageId);
}