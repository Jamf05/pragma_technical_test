import 'package:flutter/widgets.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_localizations.dart';

class AccessibilityDelegate
    extends LocalizationsDelegate<AccessibilityLocalizations> {
  static const LocalizationsDelegate<AccessibilityLocalizations> delegate =
      AccessibilityDelegate();
  const AccessibilityDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AccessibilityLocalizations> load(Locale locale) async {
    AccessibilityLocalizations localizations =
        AccessibilityLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<AccessibilityLocalizations> old) =>
      false;
}
