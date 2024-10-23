import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedRemoteDataSource remoteDataSource;

  BreedRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<BreedEntity>>> getBreeds(
      {required int page, int? limit}) async {
    try {
      final response =
          await remoteDataSource.getBreeds(page: page, limit: limit);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<BreedEntity>>> search(
      {required String query, int? attachImage}) async {
    try {
      final response =
          await remoteDataSource.search(query: query, attachImage: attachImage);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ImageBreedEntity>> getImage(
      String referenceImageId) async {
    try {
      final response = await remoteDataSource.getImage(referenceImageId);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
