import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';

void main() {
  setUp(() async {
    await Env.load(fileName: AssetsToken.env.test.aEnv);
  });

  test('Try get property API_URL successful', () async {
    // act
    final result = Env.api;
    // assert
    expect(result, isA<String>());
  });

  test('Try get property API_KEY successful', () async {
    // act
    final result = Env.apiKey;
    // assert
    expect(result, isA<String>());
  });

  test('Try get property NETWORK_PLACEHOLDER successful', () async {
    // act
    final result = Env.networkPlaceholder;
    // assert
    expect(result, isA<String>());
  });
}