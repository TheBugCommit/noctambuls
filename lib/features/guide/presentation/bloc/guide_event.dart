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

final class CheckBirdAudioWarningRequested extends GuideEvent {
  const CheckBirdAudioWarningRequested({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
}

final class AcceptAudioWarning extends GuideEvent {
  const AcceptAudioWarning({required this.audioPath});

  final String audioPath;

  @override
  List<Object?> get props => [audioPath];
}
