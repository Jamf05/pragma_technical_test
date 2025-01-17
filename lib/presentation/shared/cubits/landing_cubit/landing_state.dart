part of 'landing_cubit.dart';

sealed class LandingState extends Equatable {
  const LandingState();

  @override
  List<Object> get props => <Object>[];
}

final class LandingInitial extends LandingState {}

final class LandingInitialLoading extends LandingState {}

final class LandingInitialLoaded extends LandingState {}

final class LandingError extends LandingState {
  final String message;
  const LandingError(this.message);

  @override
  List<Object> get props => <Object>[message];
}