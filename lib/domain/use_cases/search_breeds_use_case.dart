import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';
import 'package:pragma_technical_test/core/use_case/use_case.dart';
import 'package:pragma_technical_test/domain/entities/breeds_entity.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';

class SearchBreedsUseCase implements UseCase2<List<BreedEntity>, String, int?> {
  final BreedRepository repository;
  SearchBreedsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BreedEntity>>> call(
      String param1, int? param2) {
    return repository.search(query: param1, attachImage: param2);
  }
}
