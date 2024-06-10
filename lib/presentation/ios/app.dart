import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/presentation/ios/routes/app_routes.dart';
import 'package:pragma_technical_test/presentation/ios/provider/theme_provider.dart';

class IosApp extends StatefulWidget {
  const IosApp({super.key});

  @override
  State<IosApp> createState() => _AppState();
}

class _AppState extends State<IosApp> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: sl<ThemeProvider>(),
        builder: (BuildContext context, Widget? child) {
          return CupertinoApp(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
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
