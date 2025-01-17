import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class ValidateExpectTheme {
  static Future<void> validate(WidgetTester tester, Finder finder,
      {Brightness brightness = Brightness.dark}) async {
    final state = tester.state(finder); // CatBreedsFinders.landingPage
    final updatedBrightness = Theme.of(state.context).brightness;
    expect(updatedBrightness, brightness);
  }
}
