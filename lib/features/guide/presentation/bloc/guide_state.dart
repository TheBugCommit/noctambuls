import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class GuideSideEffectError extends Equatable {
  const GuideSideEffectError(this.timestamp);

  final DateTime timestamp;

  @override
  List<Object?> get props => [timestamp];
}

sealed class GuideSideEffect extends Equatable {
  const GuideSideEffect(this.timestamp);

  final DateTime timestamp;

  @override
  List<Object?> get props => [timestamp];
}

final class GuideAudioError extends GuideSideEffectError {
  GuideAudioError() : super(DateTime.now());
}

final class GuideUrlError extends GuideSideEffectError {
  GuideUrlError() : super(DateTime.now());
}

final class GuideAudioWarning extends GuideSideEffect {
  GuideAudioWarning({required this.audioPath}) : super(DateTime.now());

  final String audioPath;

  @override
  List<Object?> get props => [audioPath, timestamp];
}

sealed class GuideState extends Equatable {
  const GuideState();

  GuideLoaded? get loaded => this is GuideLoaded ? this as GuideLoaded : null;

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
    GuideSideEffect? action,
  }) {
    return GuideLoaded(
      birds: birds ?? this.birds,
      actionError: actionError ?? this.actionError,
      currentlyPlayingPath: currentlyPlayingPath ?? this.currentlyPlayingPath,
      action: action ?? this.action,
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
