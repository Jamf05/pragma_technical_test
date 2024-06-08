import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/design/design.dart';
import 'package:pragma_technical_test/core/extensions/build_context.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_cubit/splash_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) async =>
          context.read<SplashCubit>().listener(context, state),
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
                    'Catbreeds',
                    style: FontsFoundation.of(context.brightness).title.h1B36,
                  ),
                  const Spacer(),
                  AssetsToken.illustrations.cat.svg(
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
