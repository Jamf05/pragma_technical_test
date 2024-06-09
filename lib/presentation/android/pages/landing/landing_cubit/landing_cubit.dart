import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:pragma_technical_test/core/extensions/build_context.dart';
import 'package:pragma_technical_test/core/utils/debounce.dart';
import 'package:pragma_technical_test/core/validators/query_input.dart';
import 'package:pragma_technical_test/domain/entities/breed_entity.dart';
import 'package:pragma_technical_test/domain/entities/image_breed_entity.dart';
import 'package:pragma_technical_test/domain/use_cases/get_breeds_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/get_image_breed_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/search_breeds_use_case.dart';
import 'package:rxdart/rxdart.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> with FormzMixin {
  final GetBreedsUseCase _getBreedsUseCase;
  final SearchBreedsUseCase _searchBreedsUseCase;
  final GetImageBreedUseCase _getImageBreedUseCase;
  LandingCubit({
    required GetBreedsUseCase getBreedsUseCase,
    required SearchBreedsUseCase searchBreedsUseCase,
    required GetImageBreedUseCase getImageBreedUseCase,
  })  : _getBreedsUseCase = getBreedsUseCase,
        _searchBreedsUseCase = searchBreedsUseCase,
        _getImageBreedUseCase = getImageBreedUseCase,
        super(LandingInitial());

  int _page = 0;
  final int _limit = 10;
  bool _hasNextPage = true;

  final Debounce _debounce =
      Debounce(duration: const Duration(milliseconds: 500));

  final List<BreedEntity> _breeds = <BreedEntity>[];
  List<BreedEntity> get breeds => _breeds;

  final Map<String, StreamController<ImageBreedEntity>> _imageControllers = {};

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  QueryInput _query = const QueryInput.pure();
  QueryInput get query => _query;

  void setQuery(String value) {
    _query = QueryInput.dirty(value: value);
    _debounce.call(_onSearch);
  }

  void init() async {
    emit(LandingInitialLoading());
    final response = await _getBreedsUseCase.call(_page, _limit);
    response.fold((l) {
      emit(LandingError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        _page++;
        _breeds.addAll(r);
      }
      emit(LandingInitialLoaded());
    });
  }

  Future<void> onRefresh() async {
    _page = 0;
    _query = const QueryInput.pure();
    _breeds.clear();
    _hasNextPage = true;
    init();
  }

  Future<void> listener(BuildContext context, LandingState state) async {
    if (state is LandingError) {
      await context.overlay.showFlushbar(
        title: context.l10n.errorTitle,
        message: state.message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
      );
    }
  }

  void addListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 250) {
        if (_hasNextPage) {
          _debounce.call(_loadMore);
        }
      }
    });
  }

  Future<void> _onSearch() async {
    log(_query.value, name: 'QUERY');
  }

  Stream<ImageBreedEntity> imageStream(String? referenceImageId) {
    if (referenceImageId == null) {
      return const Stream.empty();
    }
    if (!_imageControllers.containsKey(referenceImageId)) {
      _imageControllers[referenceImageId] = BehaviorSubject();
      _loadImage(referenceImageId);
    }
    return _imageControllers[referenceImageId]!.stream;
  }

  void _loadImage(String? referenceImageId) async {
    final response = await _getImageBreedUseCase.call(referenceImageId!);
    return response.fold((l) {
      emit(LandingError(l.message));
    }, (r) {
      _imageControllers[referenceImageId]!.add(r);
    });
  }

  void _loadMore() async {
    emit(LandingInitialLoading());
    final response = await _getBreedsUseCase.call(_page, _limit);
    response.fold((l) {
      emit(LandingError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        _page++;
        _breeds.addAll(r);
      } else {
        _hasNextPage = false;
      }
      emit(LandingInitialLoaded());
    });
  }

  @override
  List<FormzInput> get inputs => <FormzInput>[
        query,
      ];
}
