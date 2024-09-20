import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/pages/landing/widgets/cat_breed_card.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../mocks/mock_cache_manager.dart';

void main() {
  setUp(() async {
    await Env.load(fileName: AssetsToken.env.aEnvDev);
  });

  Future<void> configureScreenSize(WidgetTester tester) async {
    const size = Size(414.0, 896.0);
    await tester.binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
  }

  testWidgets('CatBreedCard', (WidgetTester tester) async {
    await configureScreenSize(tester);
    await HttpOverrides.runZoned(
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.breedJson),
        );

        final BreedEntity tBreed = BreedModel.fromJson(jsonMap);
        const tImage = 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg';

        final Widget widget = _BuildMaterialApp(
          breed: tBreed,
          imageUrl: tImage,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        // act
        final titleFinder = find.text(tBreed.name!);
        final moreFinder = find.text('More...');
        final textButtonFinder = find.byType(TextButton);
        final imageFinder = find.byType(CachedNetworkImage);
        final originFinder = find.text(tBreed.origin!);
        final temperamentFinder = find.text(tBreed.temperament!);

        // assert

        expect(titleFinder, findsOneWidget);
        expect(moreFinder, findsOneWidget);
        expect(textButtonFinder, findsOneWidget);
        expect(imageFinder, findsOneWidget);
        expect(originFinder, findsOneWidget);
        expect(temperamentFinder, findsOneWidget);
      },
      createHttpClient: (_) => HttpClient(),
    );
  });

  testWidgets('CatBreedCard methoed onPressed', (WidgetTester tester) async {
    await configureScreenSize(tester);
    await HttpOverrides.runZoned(
      () async {
        await tester.runAsync(() async {
          // arrange
          final Map<String, dynamic> jsonMap = json.decode(
            JsonHelpers.readJson(DummyData.breedJson),
          );

          final BreedEntity tBreed = BreedModel.fromJson(jsonMap);
          const tImage = 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg';

          final Widget widget = _BuildMaterialApp(
            breed: tBreed,
            imageUrl: tImage,
          );

          await tester.pumpWidget(widget);
          await tester.pumpAndSettle();

          // act
          final textButtonFinder = find.byType(TextButton);
          await tester.tap(textButtonFinder);
          await tester.pumpAndSettle();

          // assert
          expect(find.byType(DetailPage), findsOneWidget);
        });
      },
      createHttpClient: (_) => HttpClient(),
    );
  });
}

class _BuildMaterialApp extends StatelessWidget {
  final BreedEntity breed;
  final String imageUrl;

  const _BuildMaterialApp({
    required this.breed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('es'),
        Locale('en'),
      ],
      home: Scaffold(
        body: CatBreedCard(
          breed: breed,
          imageUrl: imageUrl,
        ),
      ),
      theme: ThemeFoundation.light,
      routes: <String, WidgetBuilder>{
        DetailPage.route: (BuildContext context) => DetailPage(
              breed: breed,
              imageUrl: imageUrl,
              cacheManager: MockCacheManager(),
            ),
      },
    );
  }
}
