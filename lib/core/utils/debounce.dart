import 'package:flutter/foundation.dart';
import 'dart:async';

class Debounce {
  final Duration duration;
  Timer? _timer;

  Debounce({required this.duration});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}
