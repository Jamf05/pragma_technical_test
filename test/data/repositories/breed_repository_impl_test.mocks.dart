// Mocks generated by Mockito 5.4.4 from annotations
// in pragma_technical_test/test/data/repositories/breed_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:pragma_technical_test/data/data_sources/breeds/breed_remote_data_source.dart'
    as _i3;
import 'package:pragma_technical_test/data/models/breed_model.dart' as _i5;
import 'package:pragma_technical_test/data/models/image_breed_model.dart'
    as _i2;

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

class _FakeImageBreedModel_0 extends _i1.SmartFake
    implements _i2.ImageBreedModel {
  _FakeImageBreedModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BreedRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockBreedRemoteDataSource extends _i1.Mock
    implements _i3.BreedRemoteDataSource {
  MockBreedRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.BreedModel>> getBreeds({
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
        returnValue: _i4.Future<List<_i5.BreedModel>>.value(<_i5.BreedModel>[]),
      ) as _i4.Future<List<_i5.BreedModel>>);

  @override
  _i4.Future<List<_i5.BreedModel>> search({
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
        returnValue: _i4.Future<List<_i5.BreedModel>>.value(<_i5.BreedModel>[]),
      ) as _i4.Future<List<_i5.BreedModel>>);

  @override
  _i4.Future<_i2.ImageBreedModel> getImage(String? referenceImageId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [referenceImageId],
        ),
        returnValue:
            _i4.Future<_i2.ImageBreedModel>.value(_FakeImageBreedModel_0(
          this,
          Invocation.method(
            #getImage,
            [referenceImageId],
          ),
        )),
      ) as _i4.Future<_i2.ImageBreedModel>);
}
