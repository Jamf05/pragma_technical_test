import 'package:pragma_technical_test/domain/entities/weight_entity.dart';

class WeightModel extends WeightEntity {
  const WeightModel({super.imperial, super.metric});

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
        imperial: json['imperial'],
        metric: json['metric'],
      );
}
