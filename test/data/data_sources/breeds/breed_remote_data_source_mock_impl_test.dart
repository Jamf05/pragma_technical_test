import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source_mock_impl.dart';
import 'package:pragma_technical_test/data/mocks/breeds_mock.dart';
import 'package:pragma_technical_test/data/mocks/image_breed_mock.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';

void main() {
  late BreedRemoteDataSourceMockImpl dataSource;

  setUp(() async {
    dataSource = BreedRemoteDataSourceMockImpl();
  });

  group('Method getBreeds', () {
    test('should return a successful response when page is 0', () async {
      // arrange
      const tPage = 0;
      const tLimit = 10;
      // act
      final result = await dataSource.getBreeds(page: tPage, limit: tLimit);
      // assert
      expect(result, isA<List>());
      expect(result, breedsMockPage0);
    });

    test('should return a successful response when page is 1', () async {
      // arrange
      const tPage = 1;
      const tLimit = 10;
      // act
      final result = await dataSource.getBreeds(page: tPage, limit: tLimit);
      // assert
      expect(result, isA<List>());
      expect(result, breedsMockPage1);
    });

    test('should return a successful response when page is other value', () async {
      // arrange
      const tPage = 2;
      const tLimit = 10;
      // act
      final result = await dataSource.getBreeds(page: tPage, limit: tLimit);
      // assert
      expect(result, isA<List>());
      expect(result, []);
    });
  });

  group('Method search', () {
    test('should return a successful response', () async {
      // arrange
      const tQuery = 'Abyssinian';
      final tList = [...breedsMockPage0, ...breedsMockPage1];
      final tFiltered = tList
          .where(
            (element) => element.name.toString().toLowerCase().contains(tQuery),
          )
          .toList();
      // act
      final result = await dataSource.search(query: tQuery);
      // assert
      expect(result, isA<List>());
      expect(result, tFiltered);
    });
  });

  group('Method getImage', () {
    test('should return a successful response', () async {
      // arrange
      const tReferenceImageId = 'vJ3lEYgXr';
      // act
      final result = await dataSource.getImage(tReferenceImageId);
      // assert
      expect(result, isA<ImageBreedModel>());
      expect(result, imageBreedMock);
    });
  });
}
