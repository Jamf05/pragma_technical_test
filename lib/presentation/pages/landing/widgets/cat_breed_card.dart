import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_decode_extension.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class CatBreedCard extends StatelessWidget {
  final A11YLandingPage a11YLandingPage;
  final String? imageUrl;
  final BreedEntity breed;

  const CatBreedCard({
    required this.a11YLandingPage,
    required this.breed,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        minVerticalPadding: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              breed.name ?? '',
              style: FontsFoundation.of(context.brightness).title.h1B16,
              semanticsLabel:
                  a11YLandingPage.breedName.decodeWith1Param(breed.name ?? ''),
            ),
            TextButton(
              onPressed: () async {
                context.focus.requestFocus(FocusNode());
                await context.navigator.pushNamed(
                  DetailPage.route,
                  arguments: (breed, imageUrl),
                );
              },
              child: Text(
                '${context.l10n.more}...',
                semanticsLabel: a11YLandingPage.moreButton,
              ),
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
                  cacheManager: context.read<CacheManagerCubit>().state,
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
                        semanticsLabel: a11YLandingPage.breedOrigin
                            .decodeWith1Param(breed.origin ?? ''),
                      )),
                  Flexible(
                    child: Text(
                      breed.temperament ?? '',
                      textAlign: TextAlign.end,
                      style: FontsFoundation.of(context.brightness)
                          .paragraph
                          .b1R12,
                      semanticsLabel: a11YLandingPage.breedTemperament
                          .decodeWith1Param(breed.temperament ?? ''),
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
