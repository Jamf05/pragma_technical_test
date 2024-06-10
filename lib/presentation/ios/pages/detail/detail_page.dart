import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pragma_technical_test/core/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/extensions/build_context.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/error_in_network_image_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/integer_rating_bar_widget.dart';
import 'package:pragma_technical_test/presentation/shared/widgets/placeholder_network_image_widget.dart';

class DetailPage extends StatelessWidget {
  final BreedEntity breed;
  final String? imageUrl;
  const DetailPage({required this.breed, required this.imageUrl, super.key});
  static const String route = '/detail';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      navigationBar: CupertinoNavigationBar(
        middle: Text(breed.name ?? context.l10n.catbreeds),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8.0,
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
                height: 8.0,
              ),
              Expanded(
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: CupertinoListSection(
                      topMargin: 0,
                      children: [
                        _ItemText(
                          title: context.l10n.origin,
                          value: breed.origin,
                        ),
                        _ItemRating(
                          title: context.l10n.intelligence,
                          value: breed.intelligence,
                        ),
                        _ItemRating(
                          title: context.l10n.adaptability,
                          value: breed.adaptability,
                        ),
                        _ItemText(
                          title: context.l10n.temperament,
                          value: breed.temperament,
                        ),
                        _ItemText(
                          title: context.l10n.lifeSpan,
                          value: breed.lifeSpan,
                        ),
                        _ItemRating(
                          title: context.l10n.affectionLevel,
                          value: breed.affectionLevel,
                        ),
                        _ItemRating(
                          title: context.l10n.childFriendly,
                          value: breed.childFriendly,
                        ),
                        _ItemRating(
                          title: context.l10n.dogFriendly,
                          value: breed.dogFriendly,
                        ),
                        _ItemRating(
                          title: context.l10n.energyLevel,
                          value: breed.energyLevel,
                        ),
                        _ItemRating(
                          title: context.l10n.grooming,
                          value: breed.grooming,
                        ),
                        _ItemRating(
                          title: context.l10n.healthIssues,
                          value: breed.healthIssues,
                        ),
                        _ItemRating(
                          title: context.l10n.sheddingLevel,
                          value: breed.sheddingLevel,
                        ),
                        _ItemRating(
                          title: context.l10n.socialNeeds,
                          value: breed.socialNeeds,
                        ),
                        _ItemRating(
                          title: context.l10n.strangerFriendly,
                          value: breed.strangerFriendly,
                        ),
                        _ItemRating(
                          title: context.l10n.vocalisation,
                          value: breed.vocalisation,
                        ),
                        _ItemText(
                          title: context.l10n.description,
                          value: breed.description,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemText extends StatelessWidget {
  final String title;
  final String? value;
  const _ItemText({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CupertinoListTile(
        title: SizedBox(
          width: constraints.maxWidth * 0.45,
          child: Text(
            title,
            style: FontsFoundation.of(context.brightness).paragraph.b1M14,
          ),
        ),
        additionalInfo: SizedBox(
          width: constraints.maxWidth * 0.45,
          child: Text(
            value ?? '',
            textAlign: TextAlign.end,
            style: FontsFoundation.of(context.brightness).paragraph.b2R14,
          ),
        ),
      );
    });
  }
}

class _ItemRating extends StatelessWidget {
  final String title;
  final int? value;
  const _ItemRating({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CupertinoListTile(
        title: SizedBox(
          width: constraints.maxWidth * 0.45,
          child: Text(
            title,
            style: FontsFoundation.of(context.brightness).paragraph.b1M14,
          ),
        ),
        additionalInfo: IntegerRatingBarWidget(
          initialRating: value ?? 0,
        ),
      );
    });
  }
}
