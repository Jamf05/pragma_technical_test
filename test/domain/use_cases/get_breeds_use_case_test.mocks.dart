// Mocks generated by Mockito 5.4.4 from annotations
// in pragma_technical_test/test/domain/use_cases/get_breeds_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pragma_technical_test/core/error_handling/failure.dart' as _i5;
import 'package:pragma_technical_test/domain/entities/breeds_entity.dart'
    as _i6;
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BreedRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBreedRepository extends _i1.Mock implements _i3.BreedRepository {
  MockBreedRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>> getBreeds({
    required int? page,
    int? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBreeds,
          [],
          {
            #page: page,
            #limit: limit,
          },
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.BreedEntity>>(
          this,
          Invocation.method(
            #getBreeds,
            [],
            {
              #page: page,
              #limit: limit,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>> search({
    required String? query,
    int? attachImage,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [],
          {
            #query: query,
            #attachImage: attachImage,
          },
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.BreedEntity>>(
          this,
          Invocation.method(
            #search,
            [],
            {
              #query: query,
              #attachImage: attachImage,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.BreedEntity>>>);
}
