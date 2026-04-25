import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class GuideState extends Equatable {
  const GuideState();
}

final class GuideInitial extends GuideState {
  const GuideInitial();

  @override
  List<Object?> get props => [];
}

final class GuideLoading extends GuideState {
  const GuideLoading();

  @override
  List<Object?> get props => [];
}

final class GuideLoaded extends GuideState {
  const GuideLoaded({required this.birds});

  final List<Bird> birds;

  @override
  List<Object?> get props => [birds];
}

final class GuideError extends GuideState {
  const GuideError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
