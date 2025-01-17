import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/error_handling/error.dart';
import 'package:pragma_technical_test/core/error_handling/failure.dart';

void main() {

  Future<Either<Failure, void>> testError() async{
    return Left(ErrorFailure.decode(ArgumentError()));
  }

  test('Should return a ErrorFailure', () async {
    // arrange
    // act
    final result = await testError();
    final Failure? left = result.fold((failure) => failure, (_) => null);
    // assert
    expect(result, isA<Left>());
    expect(left, isA<ErrorFailure>());
    expect((left as ErrorFailure).error, isA<ArgumentError>());
  });
}