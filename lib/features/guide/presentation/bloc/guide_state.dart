import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class GuideSideEffect extends Equatable {
  const GuideSideEffect(this.timestamp);

  final DateTime timestamp;

  @override
  List<Object?> get props => [timestamp];
}

final class GuideAudioWarning extends GuideSideEffect {
  GuideAudioWarning({required this.audioPath}) : super(DateTime.now());
  final String audioPath;

  @override
  List<Object?> get props => [audioPath, timestamp];
}

final class GuideAudioPlayApproved extends GuideSideEffect {
  GuideAudioPlayApproved({required this.audioPath}) : super(DateTime.now());
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
    this.currentlyPlayingPath,
    this.action,
  });

  final List<Bird> birds;
  final String? currentlyPlayingPath;
  final GuideSideEffect? action;

  @override
  List<Object?> get props => [birds, currentlyPlayingPath, action];

  GuideLoaded copyWith({
    List<Bird>? birds,
    String? currentlyPlayingPath,
    GuideSideEffect? action,
  }) {
    return GuideLoaded(
      birds: birds ?? this.birds,
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
