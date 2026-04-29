import 'package:equatable/equatable.dart';

sealed class GuideEvent extends Equatable {
  const GuideEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBirds extends GuideEvent {
  const LoadBirds({required this.languageCode});

  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

final class PlayBirdAudio extends GuideEvent {
  const PlayBirdAudio({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
}

final class OpenBirdLink extends GuideEvent {
  const OpenBirdLink({required this.url});

  final String url;

  @override
  List<Object?> get props => [url];
}
