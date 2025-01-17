import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void init() {
    Future<void>.delayed(const Duration(seconds: 2), () {
      emit(SplashLoaded());
    });
  }
}
