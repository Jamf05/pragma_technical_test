import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

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

  double _oldPosition = 0.0;

  final Debounce _debounce =
      Debounce(duration: const Duration(milliseconds: 500));

  final List<BreedEntity> _originBreeds = <BreedEntity>[];
  final List<BreedEntity> _searchBreeds = <BreedEntity>[];
  List<BreedEntity> get breeds {
    if (query.value.isNotEmpty) {
      return _searchBreeds;
    }
    return _originBreeds;
  }

  final Map<String, StreamController<ImageBreedEntity>> _imageControllers = {};
  Map<String, StreamController<ImageBreedEntity>> get imageControllers =>
      _imageControllers;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  QueryInput _query = const QueryInput.pure();
  QueryInput get query => _query;

  TextEditingController queryController = TextEditingController();

  void setQuery(String value) {
    _query = QueryInput.dirty(value: value);
    _debounce.call(onSearch);
    if (value.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_oldPosition);
        }
      });
    }
  }

  void init() async {
    emit(LandingInitialLoading());
    final response = await _getBreedsUseCase.call(_page, _limit);
    response.fold((l) {
      emit(LandingError(l.message));
    }, (r) {
      if (r.isNotEmpty) {
        _page++;
        _originBreeds.addAll(r);
      }
    });
    emit(LandingInitialLoaded());
  }

  Future<void> onRefresh() async {
    _page = 0;
    _query = const QueryInput.pure();
    _originBreeds.clear();
    _hasNextPage = true;
    init();
  }
  void addListener() {
    _scrollController.addListener(() {
      if (_query.value.isEmpty) {
        _oldPosition = _scrollController.position.pixels;
      }
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 250) {
        if (_hasNextPage && query.value.isEmpty) {
          _debounce.call(_loadMore);
        }
      }
    });
  }

  Future<void> onSearch() async {
    emit(LandingInitialLoading());
    if (query.value.isEmpty) {
      emit(LandingInitialLoaded());
      return;
    }
    final response = await _searchBreedsUseCase.call(query.value, null);
    response.fold((l) {
      emit(LandingError(l.message));
    }, (r) {
      _searchBreeds.clear();
      _searchBreeds.addAll(r);
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
    emit(LandingInitialLoaded());
  }

  void clearInput() async {
    queryController.clear();
    _query = const QueryInput.pure();
    emit(LandingInitialLoading());
    emit(LandingInitialLoaded());
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
        _originBreeds.addAll(r);
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
