part of '../design.dart';

class ThemeFoundation {
  ThemeFoundation._internal();
  static final CupertinoThemeData light = CupertinoThemeData(
    /**
     * scaffoldBackgroundColor
     */
    scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
    /**
     * brightness
     */
    brightness: Brightness.light,
    /**
     * primaryColor
     */
    primaryColor: ColorsFoundation.primary,
    /*
      * titleMedium
      */
    textTheme: CupertinoTextThemeData(
      textStyle: FontsFoundation.of(Brightness.light).inputDecoration.style,
    ),
  );

  static final CupertinoThemeData dark = CupertinoThemeData(
    /**
     * scaffoldBackgroundColor
     */
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    /**
     * brightness
     */
    brightness: Brightness.dark,
    /**
     * primaryColor
     */
    primaryColor: ColorsFoundation.secondary,

    /*
      * titleMedium
      */
    textTheme: CupertinoTextThemeData(
      textStyle: FontsFoundation.of(Brightness.dark).inputDecoration.style,
    ),
  );
}
