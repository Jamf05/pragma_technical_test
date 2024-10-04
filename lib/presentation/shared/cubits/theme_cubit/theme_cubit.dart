import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pragma_technical_test/presentation/design/design.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_initial);

  static final ThemeData _initial =
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.light
          ? ThemeFoundation.light
          : ThemeFoundation.dark;

  ThemeData get selected => state;

  void setTheme(ThemeData theme) {
    emit(theme);
  }
}
