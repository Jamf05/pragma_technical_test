import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/presentation/android/app.dart';
import 'package:pragma_technical_test/dependency_injection.dart' as di;
import 'package:pragma_technical_test/presentation/ios/app.dart';

Future<void> main() async {
  await Env.load(fileName: AssetsToken.env.aEnvQa);
  await di.init();
  runApp(
    Platform.isAndroid ? const AndroidApp() : const IosApp(),
  );
}
