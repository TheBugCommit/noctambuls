import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class GuideSideEffectError extends Equatable {
  const GuideSideEffectError();

  @override
  List<Object?> get props => [];
}

final class GuideAudioError extends GuideSideEffectError {
  const GuideAudioError();
}

final class GuideUrlError extends GuideSideEffectError {
  const GuideUrlError();
}

sealed class GuideState extends Equatable {
  const GuideState();

  @override
  List<Object?> get props => [];
}

final class GuideInitial extends GuideState {
  const GuideInitial();
}

final class GuideLoading extends GuideState {
  const GuideLoading();
}

final class GuideLoaded extends GuideState {
  const GuideLoaded({
    required this.birds,
    this.actionError,
    this.currentlyPlayingPath,
  });

  final List<Bird> birds;
  final GuideSideEffectError? actionError;
  final String? currentlyPlayingPath;

  @override
  List<Object?> get props => [birds, actionError, currentlyPlayingPath];

  GuideLoaded copyWith({
    List<Bird>? birds,
    GuideSideEffectError? actionError,
    String? currentlyPlayingPath,
    bool clearError = false,
  }) {
    return GuideLoaded(
      birds: birds ?? this.birds,
      actionError: clearError ? null : (actionError ?? this.actionError),
      currentlyPlayingPath: currentlyPlayingPath ?? this.currentlyPlayingPath,
    );
  }
}

final class GuideError extends GuideState {
  const GuideError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class GuideEmptyNeedsSync extends GuideState {
  const GuideEmptyNeedsSync();
}
