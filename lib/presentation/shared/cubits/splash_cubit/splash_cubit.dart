import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pragma_technical_test/presentation/extensions/build_context.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';

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
      await context.navigator.pushReplacementNamed(LandingPage.route);
    }
  }
}
