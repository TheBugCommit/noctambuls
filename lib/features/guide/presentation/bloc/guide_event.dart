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
