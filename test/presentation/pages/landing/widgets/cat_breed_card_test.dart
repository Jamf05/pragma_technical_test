import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_localizations.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/pages/landing/widgets/cat_breed_card.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../mocks/mock_cache_manager.dart';

class MockCacheManagerCubit extends MockCubit<BaseCacheManager>
    implements CacheManagerCubit {
  MockCacheManagerCubit() : super();

  @override
  BaseCacheManager state = MockCacheManager();
}

void main() {
  late CacheManagerCubit mockCacheManagerCubit;
  setUpAll(() async {
    await Env.load(fileName: AssetsToken.env.test.aEnv);
    mockCacheManagerCubit = MockCacheManagerCubit();
  });

  testWidgets('CatBreedCard', (WidgetTester tester) async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      JsonHelpers.readJson(DummyData.breedJson),
    );

    final BreedEntity tBreed = BreedModel.fromJson(jsonMap);
    const tImage = 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg';

    final Widget widget = _BuildApp(
      mockCacheManagerCubit: mockCacheManagerCubit,
      child: _BuildMaterialApp(
        breed: tBreed,
        imageUrl: tImage,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump();

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
  });

  testWidgets('CatBreedCard method onPressed', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        JsonHelpers.readJson(DummyData.breedJson),
      );

      final BreedEntity tBreed = BreedModel.fromJson(jsonMap);
      const tImage = 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg';

      final Widget widget = _BuildApp(
        mockCacheManagerCubit: mockCacheManagerCubit,
        child: _BuildMaterialApp(
          breed: tBreed,
          imageUrl: tImage,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pump();

      // act
      final textButtonFinder = find.byType(TextButton);
      await tester.tap(textButtonFinder);
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }
      // assert
      final detailPageFinder = find.byType(DetailPage);
      expect(detailPageFinder, findsOneWidget);
    });
  });
}

class _BuildApp extends StatelessWidget {
  final CacheManagerCubit mockCacheManagerCubit;
  final Widget child;

  const _BuildApp({
    required this.child,
    required this.mockCacheManagerCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CacheManagerCubit>(
          create: (BuildContext context) => mockCacheManagerCubit,
        ),
      ],
      child: child,
    );
  }
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CatBreedCard(
              breed: breed,
              imageUrl: imageUrl,
              a11YLandingPage: AccessibilityLocalizations.of(context)!
                  .getJsonTranslate()
                  .a11YLandingPage,
            ),
          ],
        ),
      ),
      theme: ThemeFoundation.light,
      routes: <String, WidgetBuilder>{
        DetailPage.route: (BuildContext context) => DetailPage(
              breed: breed,
              imageUrl: imageUrl,
              a11YDetailPage: AccessibilityLocalizations.of(context)!
                  .getJsonTranslate()
                  .a11YDetailPage,
            ),
      },
    );
  }
}
