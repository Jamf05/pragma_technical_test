import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';

class PlaceholderNetworkImageWidget extends StatelessWidget {
  const PlaceholderNetworkImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: ColorsFoundation.background.brightGrey,
      alignment: Alignment.center,
      child: Lottie.asset(
        AssetsToken.animations.dotsSpinner.path,
      ),
    );
  }
}
