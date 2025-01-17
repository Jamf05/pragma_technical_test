import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../flows/finders/cat_breeds_finders.dart';

final class ValidateExpectTheme {
  static Future<void> validate(WidgetTester tester, {Brightness brightness = Brightness.dark}) async {
    final context = tester.element(CatBreedsFinders.materialApp);
    final updatedBrightness = Theme.of(context).brightness;
    expect(updatedBrightness, brightness);
  }
}