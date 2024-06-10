import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pragma_technical_test/core/design/design.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selected =
      PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? ThemeFoundation.light
          : ThemeFoundation.dark;
          
  ThemeData get selected => _selected;

  void setTheme(ThemeData mode) {
    _selected = mode;
    notifyListeners();
  }
}
