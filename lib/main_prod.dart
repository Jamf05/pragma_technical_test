import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/bloc/bloc_observer.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/presentation/android/app.dart';
import 'package:pragma_technical_test/dependency_injection.dart' as di;
import 'package:pragma_technical_test/presentation/ios/app.dart';

Future<void> main() async {
  await Env.load(fileName: AssetsToken.env.aEnvProd);
  await di.init();
  Bloc.observer = CustomBlocObserver();
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(
    Platform.isAndroid ? const AndroidApp() : const IosApp(),
  );
}
