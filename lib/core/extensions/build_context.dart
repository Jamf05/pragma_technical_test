import 'package:flutter/material.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/core/utils/custom_overlays.dart';

extension MediaQueryExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension FocusExtension on BuildContext {
  FocusScopeNode get focus => FocusScope.of(this);
}

extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}

extension DarkModeExtension on BuildContext {
  bool get isBrightnessDark => Theme.of(this).brightness == Brightness.dark;
}

extension BrightnessExtension on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
}

extension OverlayExtension on BuildContext {
  CustomOverlays get overlay => CustomOverlays.of(this);
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
