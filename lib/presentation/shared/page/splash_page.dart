import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/splash_cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String route = '/';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<SplashCubit>().init();
    super.initState();
  }

  Future<void> listener(BuildContext context, SplashState state) async {
    if (state is SplashLoaded) {
      await context.navigator.pushReplacementNamed(LandingPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) async =>
          listener(context, state),
      child: Scaffold(
        body: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Spacer(),
                  Text(
                    key: const Key('ptt_splash_catbreeds_key'),
                    context.l10n.catbreeds,
                    style: FontsFoundation.of(context.brightness).title.h1B36,
                  ),
                  const Spacer(),
                  AssetsToken.illustrations.cat.svg(
                    key: const Key('ptt_splash_cat_illustration_key'),
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
