import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/presentation/shared/cubits/cache_manager_cubit/cache_manager_cubit.dart';

void main() {
  late CacheManagerCubit cubit;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    cubit = CacheManagerCubit();
  });

  group('CacheManagerCubit', () {
    test('initial state is DefaultCacheManager', () {
      expect(cubit.state, equals(DefaultCacheManager()));
    });
  });
}
