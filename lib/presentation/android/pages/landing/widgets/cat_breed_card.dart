import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class CatBreedCard extends StatelessWidget {
  final String imageUrl;
  final BreedEntity breed;
  const CatBreedCard({required this.breed, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        minVerticalPadding: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(breed.name ?? ''),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
        subtitle: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                placeholder: (BuildContext context, String url) =>
                    const PlaceholderNetworkImageWidget(),
                errorWidget: (BuildContext context, String url, Object error) =>
                    const ErrorInNetworkImageWidget(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(breed.origin ?? '')),
                  Flexible(
                    child: Text(
                      breed.temperament ?? '',
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
