import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/presentation/android/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/presentation/android/extensions/build_context.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/widgets/cat_breed_card.dart';
import 'package:pragma_technical_test/presentation/android/provider/theme_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const String route = '/landing';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late LandingCubit bloc;
  @override
  void initState() {
    bloc = context.read<LandingCubit>()
      ..init()
      ..addListener();

    super.initState();
  }

  List<Widget> get actions => [
        IconButton(
            onPressed: () {
              sl<ThemeProvider>().setTheme(
                context.isBrightnessDark
                    ? ThemeFoundation.light
                    : ThemeFoundation.dark,
              );
            },
            icon: Icon(
              context.isBrightnessDark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              color: context.isBrightnessDark
                  ? ColorsFoundation.background.white
                  : ColorsFoundation.background.black,
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.catbreeds),
        actions: actions,
      ),
      body: BlocConsumer<LandingCubit, LandingState>(
        bloc: bloc,
        listener: (BuildContext context, LandingState state) async =>
            bloc.listener.call(context, state),
        buildWhen: (LandingState previous, LandingState current) =>
            current is LandingInitialLoading || current is LandingInitialLoaded,
        builder: (BuildContext context, LandingState state) {
          return Stack(
            children: [
              const _Body(),
              if (state is LandingInitialLoading)
                const Positioned.fill(
                  bottom: 10.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator()
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final LandingCubit bloc = context.read<LandingCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          TextField(
              controller: bloc.queryController,
              onTapOutside: (_) => context.focus.unfocus(),
              onChanged: (String value) => bloc.setQuery(value.trim()),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    context.focus.unfocus();
                    await bloc.onSearch();
                  },
                  icon: AssetsToken.icons.search.svg(
                    colorFilter: ColorFilter.mode(
                        ColorsFoundation.text.grey, BlendMode.srcIn),
                  ),
                ),
              )),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<LandingCubit, LandingState>(
            bloc: bloc,
            buildWhen: (LandingState previous, LandingState current) =>
                current is LandingInitialLoaded,
            builder: (context, state) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: bloc.onRefresh,
                  child: ListView.builder(
                    controller: bloc.scrollController,
                    itemCount: bloc.breeds.length,
                    padding: const EdgeInsets.only(bottom: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final breed = bloc.breeds[index];
                      final imageStream =
                          bloc.imageStream(breed.referenceImageId);
                      return StreamBuilder<ImageBreedEntity>(
                        key: Key(breed.id!),
                        stream: imageStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<ImageBreedEntity> snapshot) {
                          return CatBreedCard(
                            key: Key(breed.id!),
                            breed: breed,
                            imageUrl: snapshot.hasData
                                ? snapshot.data?.url
                                : Env.networkPlaceholder,
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
