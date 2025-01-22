import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomOverlays {
  final BuildContext _context;
  CustomOverlays._(this._context);

  static CustomOverlays of(BuildContext context) {
    return CustomOverlays._(context);
  }

  Future<void> showFlushbar({
    required String title,
    required String message,
    required Icon icon,
    Key? key,
  }) async {
    if (message.isNotEmpty) {
      await Flushbar(
        key: key,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        icon: icon,
      ).show(_context);
    }
  }
}
