// ignore_for_file: library_private_types_in_public_api

part of '../design.dart';

class StylesFoundation {
  final Brightness brightness;
  static StylesFoundation of(Brightness brightness) =>
      StylesFoundation._internal(brightness);
  StylesFoundation._internal(this.brightness);

  static final ScrollBehavior scrollBehavior =
      const ScrollBehavior().copyWith(physics: const BouncingScrollPhysics());

  static const EdgeInsets contentPaddingInput =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static final List<BoxShadow> boxShadow = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.black.withOpacity(0.2),
      offset: const Offset(0, 2),
      blurRadius: 5,
    )
  ];
  static final List<BoxShadow> boxShadowDark = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.white.withOpacity(0.2),
      offset: const Offset(0, 2),
      blurRadius: 5,
    )
  ];

  static final List<BoxShadow> boxShadowAvart = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.black.withOpacity(0.25),
      offset: const Offset(0, 4),
      blurRadius: 5,
    )
  ];
}