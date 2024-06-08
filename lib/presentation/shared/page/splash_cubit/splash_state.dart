part of 'splash_cubit.dart';

@immutable
sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => <Object>[];
}

final class SplashInitial extends SplashState {}

final class SplashLoaded extends SplashState {}
