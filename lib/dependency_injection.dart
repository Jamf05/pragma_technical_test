import 'package:get_it/get_it.dart';
import 'package:pragma_technical_test/core/http/dio_http_client.dart';
import 'package:pragma_technical_test/data/data_sources/breed_remote_data_source.dart';
import 'package:pragma_technical_test/data/repositories/breed_repository_impl.dart';
import 'package:pragma_technical_test/domain/repositories/breed_repository.dart';
import 'package:pragma_technical_test/domain/use_cases/get_breeds_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/get_image_breed_use_case.dart';
import 'package:pragma_technical_test/domain/use_cases/search_breeds_use_case.dart';
import 'package:pragma_technical_test/presentation/android/shared/cubits/landing_cubit/landing_cubit.dart';
import 'package:pragma_technical_test/presentation/android/shared/cubits/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/android/provider/theme_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /**
   * Blocs
   */

  sl.registerFactory(() => SplashCubit());
  sl.registerFactory(() => LandingCubit(
        getBreedsUseCase: sl(),
        searchBreedsUseCase: sl(),
        getImageBreedUseCase: sl(),
      ));

  /**
   * Use Cases
   */

  sl.registerLazySingleton(() => GetBreedsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchBreedsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetImageBreedUseCase(repository: sl()));

  /** 
   * Repositories
   */

  sl.registerLazySingleton<BreedRepository>(
      () => BreedRepositoryImpl(remoteDataSource: sl()));

  /**
   * Data Sources
   */

  sl.registerLazySingleton<BreedRemoteDataSource>(
      () => BreedRemoteDataSourceImpl(client: DioHttpClient()));

  /**
   *  Http Client
   */

  /**
   * Externals
   */

  sl.registerLazySingleton(
    () => ThemeProvider(),
  );
}
