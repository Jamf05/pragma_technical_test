import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class CatBreedCard extends StatelessWidget {
  const CatBreedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        minVerticalPadding: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Item 0'),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            CachedNetworkImage(
              imageUrl: 'https://translate.google.com.co/',
              height: 100,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) =>
                  const PlaceholderNetworkImageWidget(),
              errorWidget: (BuildContext context, String url, Object error) =>
                  const ErrorInNetworkImageWidget(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Pais origen'),
                Text('Inteligencia'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
