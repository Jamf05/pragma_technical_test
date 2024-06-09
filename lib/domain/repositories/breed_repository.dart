import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';
import 'package:pragma_technical_test/domain/entities/breeds_entity.dart';

abstract class BreedRepository {
  Future<Either<Failure, List<BreedEntity>>> getBreeds(
      {required int page, int limit});
  Future<Either<Failure, List<BreedEntity>>> search(
      {required String query, int? attachImage});
}
