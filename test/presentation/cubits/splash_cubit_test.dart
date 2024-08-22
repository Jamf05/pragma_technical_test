import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/presentation/android/shared/cubits/splash_cubit/splash_cubit.dart';

void main() {
  late SplashCubit cubit;

  setUp(() {
    cubit = SplashCubit();
  });

  test(
    'initial state should be empty',
    () {
      expect(cubit.state, SplashInitial());
    },
  );

  blocTest<SplashCubit, SplashState>(
    'emits [SplashLoaded] when function is added.',
    build: () => cubit,
    act: (bloc) => bloc.init(),
    wait: const Duration(seconds: 3),
    expect: () => <SplashState>[
      SplashLoaded()
    ],
  );
}
