import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/data/models/weight_model.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const WeightModel tWeight = WeightModel(
    imperial: '7  -  10',
    metric: '3 - 5',
  );

  group('Method from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.weightJson),
        );

        // act
        final WeightModel result = WeightModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tWeight));
      },
    );
  });
}
