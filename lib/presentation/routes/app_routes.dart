import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/core/accessibility/accessibility_localizations.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> of(BuildContext context) {
    return <String, Widget Function(BuildContext)>{
      SplashPage.route: (BuildContext context) => BlocProvider<SplashCubit>(
            create: (BuildContext context) => sl<SplashCubit>(),
            child: const SplashPage(),
          ),
      LandingPage.route: (BuildContext context) => BlocProvider<LandingCubit>(
            create: (BuildContext context) => sl<LandingCubit>(),
            child: LandingPage(
              a11YLandingPage: AccessibilityLocalizations.of(context)!
                  .getJsonTranslate()
                  .a11YLandingPage,
            ),
          ),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailPage.route:
        (BreedEntity, String?) record =
            settings.arguments as (BreedEntity, String?);
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DetailPage(
            breed: record.$1,
            imageUrl: record.$2,
            a11YDetailPage: AccessibilityLocalizations.of(context)!
                .getJsonTranslate()
                .a11YDetailPage,
          ),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
