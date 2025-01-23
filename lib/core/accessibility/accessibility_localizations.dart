import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_delegate.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_catbreeds.dart';

class AccessibilityLocalizations {
  final Locale locale;
  static const AccessibilityDelegate delegate = AccessibilityDelegate();
  Map<String, dynamic> _localizationsStrings = {};

  AccessibilityLocalizations(this.locale);

  static AccessibilityLocalizations? of(BuildContext context) {
    return Localizations.of(context, AccessibilityLocalizations);
  }

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(
      'assets/accessibility/${locale.languageCode}/accessibility.json',
    );

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizationsStrings = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });

    return true;
  }

  Map<String, dynamic>? translate(String key) {
    return _localizationsStrings[key];
  }

  A11YCatbreeds getJsonTranslate() =>
      A11YCatbreeds.fromJson(_localizationsStrings);
}
