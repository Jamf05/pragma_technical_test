import 'package:flutter/material.dart';
import 'package:pragma_technical_test/core/design/design.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selected = ThemeFoundation.light;
  ThemeData get selected => _selected;

  void setTheme(ThemeData mode) {
    _selected = mode;
    notifyListeners();
  }
}
