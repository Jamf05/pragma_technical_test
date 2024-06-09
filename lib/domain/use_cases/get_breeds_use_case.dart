import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';
import 'package:pragma_technical_test/core/use_case/use_case.dart';
import 'package:pragma_technical_test/domain/entities/breeds_entity.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';

class GetBreedsUseCase implements UseCase2<List<BreedEntity>, int, int> {
  final BreedRepository repository;
  GetBreedsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BreedEntity>>> call(int page, int limit) {
    return repository.getBreeds(page: page, limit: limit);
  }
}
