import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/bloc/bloc_observer.dart';
import 'package:pragma_technical_test/core/env.dart';
import 'package:pragma_technical_test/core/gen/assets.gen.dart';
import 'package:pragma_technical_test/presentation/app.dart';
import 'package:pragma_technical_test/dependency_injection.dart' as di;
import 'package:pragma_technical_test/presentation/shared/cubits/theme_cubit/theme_cubit.dart';

Future<void> main() async {
  await Env.load(fileName: AssetsToken.env.aEnvQa);
  await di.init();
  Bloc.observer = CustomBlocObserver();
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(
    BlocProvider<ThemeCubit>(
      create: (BuildContext context) => ThemeCubit(),
      child: const App(),
    ),
  );
}
