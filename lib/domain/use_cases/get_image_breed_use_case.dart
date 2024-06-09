import 'package:dartz/dartz.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';
import 'package:pragma_technical_test/core/use_case/use_case.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';

class GetImageBreedUseCase implements UseCase<ImageBreedEntity, String> {
  final BreedRepository repository;
  GetImageBreedUseCase({required this.repository});

  @override
  Future<Either<Failure, ImageBreedEntity>> call(String referenceImageId) {
    return repository.getImage(referenceImageId);
  }
}
