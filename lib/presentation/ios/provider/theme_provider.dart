import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:pragma_technical_test/presentation/ios/design/design.dart';

class ThemeProvider extends ChangeNotifier {
  CupertinoThemeData _selected =
      PlatformDispatcher.instance.platformBrightness == Brightness.light
          ? ThemeFoundation.light
          : ThemeFoundation.dark;

  CupertinoThemeData get selected => _selected;

  void setTheme(CupertinoThemeData mode) {
    _selected = mode;
    notifyListeners();
  }
}
