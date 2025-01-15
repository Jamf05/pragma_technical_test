import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/validators/query_input.dart';

void main() {
  setUp(() async {});

  test('QueryInput is Pure', () async {
    // arrange
    const tQueryInput = QueryInput.pure();
    // act
    final result = tQueryInput.isPure;
    // assert
    expect(result, isA<bool>());
    expect(result, equals(true));
  });

  test('QueryInput is valid', () async {
    // arrange
    const tQueryInput = QueryInput.dirty(value: 'value');
    // act
    final isPure = tQueryInput.isPure;
    final result = tQueryInput.validator(tQueryInput.value);
    // assert
    expect(isPure, equals(false));
    expect(result, isNull);
  });

  test('QueryInput is invalid', () async {
    // arrange
    const tQueryInput = QueryInput.dirty();
    // act
    final isPure = tQueryInput.isPure;
    final result = tQueryInput.validator(tQueryInput.value);
    // assert
    expect(isPure, equals(false));
    expect(result, isA<QueryInputError>());
    expect(result, equals(QueryInputError.empty));
  });
}
