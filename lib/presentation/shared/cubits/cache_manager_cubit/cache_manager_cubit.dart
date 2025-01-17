import 'package:bloc/bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManagerCubit extends Cubit<BaseCacheManager> {
  CacheManagerCubit() : super(DefaultCacheManager());
}
