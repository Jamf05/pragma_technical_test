import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pragma_technical_test/core/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/extensions/build_context.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/android/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class CatBreedCard extends StatelessWidget {
  final String? imageUrl;
  final BreedEntity breed;
  const CatBreedCard({required this.breed, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
      ),
      child: CupertinoListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              breed.name ?? '',
              style: FontsFoundation.of(context.brightness).title.h1B16,
            ),
            CupertinoButton(
              onPressed: () async {
                context.focus.requestFocus(FocusNode());
                await context.navigator.pushNamed(
                  DetailPage.route,
                  arguments: (breed, imageUrl),
                );
              },
              child: Text('${context.l10n.more}...'),
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
              Hero(
                tag: breed.id!,
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? Env.networkPlaceholder,
                  width: double.infinity,
                  height: 250,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  placeholder: (BuildContext context, String url) =>
                      const PlaceholderNetworkImageWidget(),
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          const ErrorInNetworkImageWidget(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Text(
                        breed.origin ?? '',
                        style: FontsFoundation.of(context.brightness)
                            .paragraph
                            .b1M12,
                      )),
                  Flexible(
                    child: Text(
                      breed.temperament ?? '',
                      textAlign: TextAlign.end,
                      style: FontsFoundation.of(context.brightness)
                          .paragraph
                          .b1R12,
                      maxLines: 3,
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
