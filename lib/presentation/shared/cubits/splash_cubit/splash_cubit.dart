import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pragma_technical_test/presentation/android/extensions/build_context.dart';
import 'package:pragma_technical_test/presentation/android/pages/landing/landing_page.dart'
    as android;
import 'package:pragma_technical_test/presentation/ios/pages/landing/landing_page.dart'
    as ios;

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void init() {
    Future<void>.delayed(const Duration(seconds: 2), () {
      emit(SplashLoaded());
    });
  }

  Future<void> listener(BuildContext context, SplashState state) async {
    if (state is SplashLoaded) {
      await context.navigator.pushReplacementNamed(
        Platform.isAndroid ? android.LandingPage.route : ios.LandingPage.route,
      );
    }
  }
}
