import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:pragma_technical_test/core/utils/debounce.dart';
import 'package:pragma_technical_test/core/validators/query_input.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> with FormzMixin {
  LandingCubit() : super(LandingInitial());

  final Debounce _debounce =
      Debounce(duration: const Duration(milliseconds: 500));

  QueryInput _query = const QueryInput.pure();
  QueryInput get query => _query;

  void setQuery(String value) {
    _query = QueryInput.dirty(value: value);
    _debounce.call(_onSearch);
  }

  void init() async {
    emit(LandingInitialLoading());
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(LandingInitialLoaded());
  }

  Future<void> onRefresh() async {
    emit(LandingInitialLoading());
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(LandingInitialLoaded());
  }

  Future<void> _onSearch() async {
    log(_query.value, name: 'QUERY');
  }

  void listener(BuildContext context, LandingState state) {}

  @override
  List<FormzInput<dynamic, dynamic>> get inputs =>
      <FormzInput<dynamic, dynamic>>[
        query,
      ];
}
