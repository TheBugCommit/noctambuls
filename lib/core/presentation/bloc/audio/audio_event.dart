import 'package:equatable/equatable.dart';

sealed class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleAudioRequested extends AudioEvent {
  const ToggleAudioRequested({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
}

final class AudioStateChangedInternal extends AudioEvent {
  const AudioStateChangedInternal({this.playingPath});

  final String? playingPath;

  @override
  List<Object?> get props => [playingPath];
}

final class PreloadAudioRequested extends AudioEvent {
  const PreloadAudioRequested({required this.audioPaths});

  final List<String> audioPaths;

  @override
  List<Object?> get props => [audioPaths];
}
