import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/presentation/android/routes/app_routes.dart';
import 'package:pragma_technical_test/presentation/android/provider/theme_provider.dart';

class AndroidApp extends StatefulWidget {
  const AndroidApp({super.key});

  @override
  State<AndroidApp> createState() => _AppState();
}

class _AppState extends State<AndroidApp> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: sl<ThemeProvider>(),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('es'),
              Locale('en'),
            ],
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.of(context),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: sl<ThemeProvider>().selected,
          );
        });
  }
}
