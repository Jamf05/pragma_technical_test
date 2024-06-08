import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pragma_technical_test/core/localization/app_localizations.dart';

class IosApp extends StatefulWidget {
  const IosApp({super.key});

  @override
  State<IosApp> createState() => _AppState();
}

class _AppState extends State<IosApp> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale('es'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
