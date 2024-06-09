import 'package:equatable/equatable.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';

class ImageBreedEntity extends Equatable {
  final String? id;
  final String? url;
  final List<BreedEntity> breeds;
  final int? width;
  final int? height;

  const ImageBreedEntity({
    this.id,
    this.url,
    this.breeds = const [],
    this.width,
    this.height,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        url,
        breeds,
        width,
        height,
      ];
}
