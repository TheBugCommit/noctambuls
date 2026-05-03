import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';

sealed class AudioState extends Equatable {
  const AudioState({this.currentlyPlayingPath});

  final String? currentlyPlayingPath;

  @override
  List<Object?> get props => [currentlyPlayingPath];
}

final class AudioInitial extends AudioState {
  const AudioInitial() : super();
}

final class AudioPlaying extends AudioState {
  const AudioPlaying({required String currentlyPlayingPath})
    : super(currentlyPlayingPath: currentlyPlayingPath);
}

final class AudioStopped extends AudioState {
  const AudioStopped() : super();
}

final class AudioActionFailure extends AudioState {
  const AudioActionFailure({
    required this.failure,
    required this.timestamp,
    super.currentlyPlayingPath,
  });

  final Failure failure;
  final DateTime timestamp;

  @override
  List<Object?> get props => [failure, currentlyPlayingPath, timestamp];
}
