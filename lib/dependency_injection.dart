import 'package:get_it/get_it.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_cubit/splash_cubit.dart';
import 'package:pragma_technical_test/presentation/shared/provider/theme_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /**
   * Blocs
   */

  sl.registerFactory(() => SplashCubit());

  /**
   * Use Cases
   */

  /** 
   * Repositories
   */

  /**
   * Data Sources
   */

  /**
   *  ApiProvider
   */

  /**
   * Externals
   */

  sl.registerLazySingleton(() => ThemeProvider());
}
