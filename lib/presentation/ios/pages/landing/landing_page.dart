import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/design/design.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/extensions/build_context.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/widgets/cat_breed_card.dart';
import 'package:pragma_technical_test/presentation/shared/provider/theme_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(context.l10n.catbreeds),
        leading: CupertinoButton(
            onPressed: () {
              sl<ThemeProvider>().setTheme(
                context.isBrightnessDark
                    ? ThemeFoundation.light
                    : ThemeFoundation.dark,
              );
            },
            child: Icon(
              context.isBrightnessDark
                  ? CupertinoIcons.sun_min
                  : CupertinoIcons.moon,
              color: context.isBrightnessDark
                  ? ColorsFoundation.background.white
                  : ColorsFoundation.background.black,
            )),
      ),
      child: BlocConsumer<LandingCubit, LandingState>(
        bloc: bloc,
        listener: (BuildContext context, LandingState state) async =>
            bloc.listener.call(context, state),
        buildWhen: (LandingState previous, LandingState current) =>
            current is LandingInitialLoading || current is LandingInitialLoaded,
        builder: (BuildContext context, LandingState state) {
          return const _Body();
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
          CupertinoSearchTextField(
            controller: bloc.queryController,
            // onTapOutside: (_) => context.focus.unfocus(),
            onChanged: (String value) => bloc.setQuery(value.trim()),
            // suffix: CupertinoButton(
            //   onPressed: () async {
            //     context.focus.unfocus();
            //     await bloc.onSearch();
            //   },
            //   child: AssetsToken.icons.search.svg(
            //     colorFilter: ColorFilter.mode(
            //         ColorsFoundation.text.grey, BlendMode.srcIn),
            //   ),
            // ),
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
                child: material.RefreshIndicator.adaptive(
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