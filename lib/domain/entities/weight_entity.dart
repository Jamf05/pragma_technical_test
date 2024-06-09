import 'package:equatable/equatable.dart';

class WeightEntity extends Equatable {
  final String? imperial;
  final String? metric;

  const WeightEntity({this.imperial, this.metric});

  @override
  List<Object?> get props => <Object?>[imperial, metric];
}
