import 'package:flutter/material.dart';
import 'package:pragma_technical_test/presentation/android/design/design.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';

class ErrorInNetworkImageWidget extends StatelessWidget {
  const ErrorInNetworkImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        height: 100,
        color: ColorsFoundation.background.brightGrey,
        alignment: Alignment.center,
        child: AssetsToken.illustrations.nounSleepingCat.svg(
          height: constraints.maxHeight * 0.5,
          colorFilter: ColorFilter.mode(
            ColorsFoundation.text.blackGrey,
            BlendMode.srcIn,
          ),
        ),
      );
    });
  }
}
