import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class GuideSideEffectError extends Equatable {
  const GuideSideEffectError();

  @override
  List<Object?> get props => [];
}

sealed class GuideSideEffect extends Equatable {
  const GuideSideEffect();

  @override
  List<Object?> get props => [];
}

final class GuideAudioError extends GuideSideEffectError {
  const GuideAudioError();
}

final class GuideUrlError extends GuideSideEffectError {
  const GuideUrlError();
}

final class GuideAudioWarning extends GuideSideEffect {
  const GuideAudioWarning({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
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
    this.action,
  });

  final List<Bird> birds;
  final GuideSideEffectError? actionError;
  final String? currentlyPlayingPath;
  final GuideSideEffect? action;

  @override
  List<Object?> get props => [birds, actionError, currentlyPlayingPath, action];

  GuideLoaded copyWith({
    List<Bird>? birds,
    GuideSideEffectError? actionError,
    String? currentlyPlayingPath,
    bool clearError = false,
    GuideSideEffect? action,
    bool clearAction = false,
  }) {
    return GuideLoaded(
      birds: birds ?? this.birds,
      actionError: clearError ? null : (actionError ?? this.actionError),
      currentlyPlayingPath: currentlyPlayingPath ?? this.currentlyPlayingPath,
      action: clearAction ? null : (action ?? this.action),
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
