import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_decode_extension.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/integer_rating_bar_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class DetailPage extends StatelessWidget {
  final A11YDetailPage a11YDetailPage;
  final BreedEntity breed;
  final String? imageUrl;

  const DetailPage({
    required this.a11YDetailPage,
    required this.breed,
    required this.imageUrl,
    super.key,
  });

  static const String route = '/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          breed.name ?? context.l10n.catbreeds,
          semanticsLabel: a11YDetailPage.catbreeds,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
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
                errorWidget: (BuildContext context, String url, Object error) =>
                    const ErrorInNetworkImageWidget(),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      _ItemText(
                        title: context.l10n.origin,
                        value: breed.origin,
                        semanticsLabel: a11YDetailPage.breedOrigin
                            .decodeWith1Param(breed.origin ?? ''),
                      ),
                      _ItemRating(
                        title: context.l10n.intelligence,
                        value: breed.intelligence,
                        semanticsLabel: a11YDetailPage.breedIntelligence
                            .decodeWith2Params(breed.intelligence.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.adaptability,
                        value: breed.adaptability,
                        semanticsLabel: a11YDetailPage.breedAdaptability
                            .decodeWith2Params(breed.adaptability.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemText(
                        title: context.l10n.temperament,
                        value: breed.temperament,
                        semanticsLabel: a11YDetailPage.breedTemperament
                            .decodeWith1Param(breed.temperament ?? ''),
                      ),
                      Builder(
                        builder: (context) {
                          final List<String> split =
                              breed.lifeSpan?.split(' - ') ??
                                  List.generate(2, (_) => '');
                          final param0 = split[0];
                          final param1 = split[1];
                          return _ItemText(
                            title: context.l10n.lifeSpan,
                            value: breed.lifeSpan,
                            semanticsLabel:
                                a11YDetailPage.breedLifeSpan.decodeWith2Params(
                              param0,
                              param1,
                            ),
                          );
                        },
                      ),
                      _ItemRating(
                        title: context.l10n.affectionLevel,
                        value: breed.affectionLevel,
                        semanticsLabel: a11YDetailPage.breedAffectionLevel
                            .decodeWith2Params(breed.affectionLevel.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.childFriendly,
                        value: breed.childFriendly,
                        semanticsLabel: a11YDetailPage.breedChildFriendly
                            .decodeWith2Params(breed.childFriendly.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.dogFriendly,
                        value: breed.dogFriendly,
                        semanticsLabel: a11YDetailPage.breedDogFriendly
                            .decodeWith2Params(breed.dogFriendly.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.energyLevel,
                        value: breed.energyLevel,
                        semanticsLabel: a11YDetailPage.breedEnergyLevel
                            .decodeWith2Params(breed.energyLevel.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.grooming,
                        value: breed.grooming,
                        semanticsLabel: a11YDetailPage.breedGrooming
                            .decodeWith2Params(breed.grooming.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.healthIssues,
                        value: breed.healthIssues,
                        semanticsLabel: a11YDetailPage.breedHealthIssues
                            .decodeWith2Params(breed.healthIssues.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.sheddingLevel,
                        value: breed.sheddingLevel,
                        semanticsLabel: a11YDetailPage.breedSheddingLevel
                            .decodeWith2Params(breed.sheddingLevel.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.socialNeeds,
                        value: breed.socialNeeds,
                        semanticsLabel: a11YDetailPage.breedSocialNeeds
                            .decodeWith2Params(breed.socialNeeds.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.strangerFriendly,
                        value: breed.strangerFriendly,
                        semanticsLabel: a11YDetailPage.breedStrangerFriendly
                            .decodeWith2Params(
                                breed.strangerFriendly.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemRating(
                        title: context.l10n.vocalisation,
                        value: breed.vocalisation,
                        semanticsLabel: a11YDetailPage.breedVocalisation
                            .decodeWith2Params(breed.vocalisation.toString(),
                                kRatingLength.toString()),
                      ),
                      _ItemText(
                        title: context.l10n.description,
                        value: breed.description,
                        semanticsLabel: a11YDetailPage.breedDescription
                            .decodeWith1Param(breed.description ?? ''),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemText extends StatelessWidget {
  final String title;
  final String semanticsLabel;
  final String? value;

  const _ItemText({
    required this.title,
    required this.semanticsLabel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Semantics(
          label: semanticsLabel,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  width: constraints.maxWidth * 0.45,
                  child: Text(
                    title,
                    style:
                        FontsFoundation.of(context.brightness).paragraph.b1M14,
                  ),
                ),
              ),
              ExcludeSemantics(
                child: Container(
                  width: constraints.maxWidth * 0.45,
                  alignment: Alignment.centerRight,
                  child: Text(
                    value ?? '',
                    textAlign: TextAlign.start,
                    style:
                        FontsFoundation.of(context.brightness).paragraph.b2R14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemRating extends StatelessWidget {
  final String title;
  final String semanticsLabel;
  final int? value;

  const _ItemRating({
    required this.title,
    required this.semanticsLabel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Semantics(
          label: semanticsLabel,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExcludeSemantics(
                child: SizedBox(
                  width: constraints.maxWidth * 0.45,
                  child: Text(
                    title,
                    style:
                        FontsFoundation.of(context.brightness).paragraph.b1M14,
                  ),
                ),
              ),
              ExcludeSemantics(
                child: IntegerRatingBarWidget(
                  initialRating: value ?? 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
