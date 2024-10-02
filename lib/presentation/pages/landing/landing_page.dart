import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/pages/landing/widgets/cat_breed_card.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/theme_cubit/theme_cubit.dart';

class LandingPage extends StatefulWidget {
  @Deprecated('A centralized instance should be used')
  final BaseCacheManager cacheManager;

  const LandingPage({
    @Deprecated('A centralized instance should be used')
    required this.cacheManager,
    super.key,
  });

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

  Future<void> listener(BuildContext context, LandingState state) async {
    if (state is LandingError) {
      await context.overlay.showFlushbar(
        key: const Key('ptt_landing_error_key'),
        title: context.l10n.errorTitle,
        message: state.message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
      );
    }
  }

  List<Widget> get actions => [
        IconButton(
            key: const Key('ptt_landing_theme_button_key'),
            onPressed: () {
              context.read<ThemeCubit>().setTheme(
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
        key: const Key('ptt_landing_app_bar_key'),
        title: Text(context.l10n.catbreeds),
        actions: actions,
      ),
      body: BlocConsumer<LandingCubit, LandingState>(
        bloc: bloc,
        listener: (BuildContext context, LandingState state) async =>
            listener.call(context, state),
        buildWhen: (LandingState previous, LandingState current) =>
            current is LandingInitialLoading || current is LandingInitialLoaded,
        builder: (BuildContext context, LandingState state) {
          return Stack(
            children: [
              _Body(
                cacheManager: widget.cacheManager,
              ),
              if (state is LandingInitialLoading)
                const Positioned.fill(
                  bottom: 10.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      key: Key('ptt_landing_loading_key'),
                    ),
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
  @Deprecated('A centralized instance should be used')
  final BaseCacheManager cacheManager;

  const _Body({
    @Deprecated('A centralized instance should be used')
    required this.cacheManager,
  });

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
                key: const Key('ptt_search_button_key'),
                onPressed: () async {
                  context.focus.unfocus();
                  await bloc.onSearch();
                },
                icon: AssetsToken.icons.search.svg(
                  colorFilter: ColorFilter.mode(
                      ColorsFoundation.text.grey, BlendMode.srcIn),
                ),
              ),
            ),
          ),
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
                    key: const Key('ptt_list_view_key'),
                    controller: bloc.scrollController,
                    itemCount: bloc.breeds.length,
                    padding: const EdgeInsets.only(bottom: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final breed = bloc.breeds[index];
                      final imageStream =
                          bloc.imageStream(breed.referenceImageId);
                      return StreamBuilder<ImageBreedEntity>(
                        stream: imageStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<ImageBreedEntity> snapshot) {
                          return CatBreedCard(
                            key:
                                Key('ptt_item_cat_breed_card_${breed.id!}_key'),
                            cacheManager: cacheManager,
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
