import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/theme_cubit/theme_cubit.dart';

void main() {
  setUp(() {});

  testWidgets(
      'initial state should be ThemeFoundation.dark if platformBrightness is Brightness.dark',
      (tester) async {
    // arrange
    tester.binding.platformDispatcher.clearAllTestValues();
    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;

    // act
    ThemeCubit cubit = ThemeCubit();

    // assert
    expect(cubit.state, ThemeFoundation.dark);
  });

  testWidgets(
    'initial state should be ThemeFoundation.light',
    (tester) async {
      // arrange
      tester.binding.platformDispatcher.clearAllTestValues();
      tester.binding.platformDispatcher.platformBrightnessTestValue =
          Brightness.dark;

      // act
      ThemeCubit cubit = ThemeCubit();

      // assert
      expect(cubit.selected, ThemeFoundation.dark);
    },
  );

  testWidgets('change selected theme with setTheme function', (tester) async {
    // arrange
    tester.binding.platformDispatcher.clearAllTestValues();
    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    ThemeCubit cubit = ThemeCubit();

    // act
    cubit.setTheme(ThemeFoundation.light);

    // assert
    expect(cubit.selected, ThemeFoundation.light);
  });
}
