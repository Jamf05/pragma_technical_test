import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_technical_test/dependency_injection.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> of(BuildContext context) {
    return <String, Widget Function(BuildContext)>{
      SplashPage.route: (BuildContext context) => BlocProvider<SplashCubit>(
            create: (BuildContext context) => sl<SplashCubit>(),
            child: const SplashPage(),
          ),
      LandingPage.route: (BuildContext context) => BlocProvider<LandingCubit>(
            create: (BuildContext context) => LandingCubit(),
            child: const LandingPage(),
          ),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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
