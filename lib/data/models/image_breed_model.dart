import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';

class ImageBreedModel extends ImageBreedEntity {
  const ImageBreedModel({
    super.id,
    super.url,
    super.breeds,
    super.width,
    super.height,
  });

  factory ImageBreedModel.fromJson(Map<String, dynamic> json) =>
      ImageBreedModel(
        id: json['id'],
        url: json['url'],
        breeds: List<BreedModel>.from(
            json['breeds'].map((x) => BreedModel.fromJson(x))),
        width: json['width'],
        height: json['height'],
      );
}
