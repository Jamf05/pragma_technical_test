import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';

import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/data/models/breed_model.dart';
import 'package:pragma_technical_test/data/models/image_breed_model.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/provider/theme_provider.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';

class MockLandingCubit extends MockCubit<LandingState>
    implements LandingCubit {}

void main() {
  late ThemeProvider tThemeProvider;
  late LandingCubit mockCubit;
  late TextEditingController tQueryController;
  late ScrollController tScrollController;

  const tLandingAppBarKey = Key('ptt_landing_app_bar_key');
  const tLandingLoadingKey = Key('ptt_landing_loading_key');
  const landingErrorKey = Key('ptt_landing_error_key');
  const tListViewKey = Key('ptt_list_view_key');

  final Map<String, StreamController<ImageBreedEntity>> tImageControllers = {};

  setUp(() async {
    await Env.load(fileName: AssetsToken.env.aEnvDev);
    tThemeProvider = ThemeProvider();
    mockCubit = MockLandingCubit();
    tQueryController = TextEditingController();
    tScrollController = ScrollController();
  });

  List<Stream<ImageBreedEntity>> buildImageStreamList(List<BreedModel> breeds,
      Map<String, StreamController<ImageBreedEntity>> controllers) {
    return breeds.map((breed) {
      // ignore: close_sinks
      final StreamController<ImageBreedEntity> controller = BehaviorSubject();
      controllers[breed.referenceImageId!] = controller;
      return controller.stream;
    }).toList();
  }

  Future<void> disposeImageStreamList(
      Map<String, StreamController<ImageBreedEntity>> controllers) async {
    for (final controller in controllers.values) {
      await controller.close();
    }
    controllers.clear();
  }

  tearDown(() async {
    tQueryController.dispose();
    tScrollController.dispose();
    await disposeImageStreamList(tImageControllers);
  });

  testWidgets('LandingPage when cubit state is LandingInitial', (tester) async {
    // arrange
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(const []);

    when(() => mockCubit.state).thenReturn(LandingInitial());

    // act
    await tester.pumpWidget(tApp);
    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsNothing);
  });

  testWidgets('LandingPage when cubit state is LandingInitialLoading',
      (tester) async {
    // arrange
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(const []);

    when(() => mockCubit.state).thenReturn(LandingInitialLoading());

    // act
    await tester.pumpWidget(tApp);

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsOneWidget);
  });

  testWidgets(
      'LandingPage when cubit state is LandingInitialLoaded and one element in list',
      (tester) async {
    // arrange
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    final List tBreedRawData = json.decode(
      JsonHelpers.readJson(DummyData.breedsJson),
    );
    final List<BreedModel> tBreedList =
        tBreedRawData.map((e) => BreedModel.fromJson(e)).toList();

    final BreedModel tFrist = tBreedList.first;
    final BreedModel tLast = tBreedList.last;

    final ImageBreedModel tImageBreedModel = ImageBreedModel(
      id: tFrist.id,
      url: 'https://cdn2.thecatapi.com/images/${tFrist.id}.jpg',
    );

    final tStreamBuilderFristKey = Key('ptt_item_cat_breed_card_${tFrist.id!}_key');
    final tStreamBuilderLastKey = Key('ptt_item_cat_breed_card_${tLast.id!}_key');
    final tItemCatBreedCardKey =
        Key('ptt_item_cat_breed_card_${tFrist.id!}_key');

    final tImageStreamList =
        buildImageStreamList(tBreedList, tImageControllers);

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(tBreedList);

    when(() => mockCubit.state).thenReturn(LandingInitialLoaded());

    for (int i = 0; i < tBreedList.length; i++) {
      when(() => mockCubit.imageStream(tBreedList[i].referenceImageId))
          .thenAnswer((_) {
        return tImageStreamList[i];
      });
    }

    when(() => mockCubit.state).thenReturn(LandingInitialLoaded());

    // act
    await tester.pumpWidget(tApp);
    tImageControllers[tFrist.referenceImageId]!.add(tImageBreedModel);
    await tester.pump();

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsNothing);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byKey(tStreamBuilderFristKey), findsOneWidget);
    expect(find.byKey(tItemCatBreedCardKey), findsOneWidget);

    // act
    final listFinder = find.byKey(tListViewKey);
    final itemFinder = find.byKey(tStreamBuilderLastKey);

    await tester.dragUntilVisible(
      itemFinder,
      listFinder,
      const Offset(0, -800),
    );

    // assert
    expect(itemFinder, findsOneWidget);
  });

  testWidgets('LandingPage when cubit state is LandingError', (tester) async {
    // arrange
    final tApp = _BuildMaterialApp(
      mockCubit: mockCubit,
      tThemeProvider: tThemeProvider,
    );

    const tLandingError = LandingError('Error');

    when(() => mockCubit.queryController).thenReturn(tQueryController);
    when(() => mockCubit.scrollController).thenReturn(tScrollController);
    when(() => mockCubit.breeds).thenReturn(const []);

    whenListen<LandingState>(
      mockCubit,
      Stream<LandingState>.fromIterable(
          [LandingInitial(), LandingInitialLoading(), tLandingError]),
      initialState: LandingInitial(),
    );

    // act
    await tester.pumpWidget(tApp);
    await tester.pump();

    // assert
    expect(find.byKey(tLandingAppBarKey), findsOneWidget);
    expect(find.byKey(tLandingLoadingKey), findsOneWidget);
    expect(find.byKey(landingErrorKey), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp({
    required this.mockCubit,
    required this.tThemeProvider,
  });

  final LandingCubit mockCubit;
  final ThemeProvider tThemeProvider;

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
      home: BlocProvider<LandingCubit>(
        create: (BuildContext context) => mockCubit,
        child: const LandingPage(),
      ),
      theme: tThemeProvider.selected,
    );
  }
}
