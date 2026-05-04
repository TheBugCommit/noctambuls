import 'package:equatable/equatable.dart';

sealed class ShareEvent extends Equatable {
  const ShareEvent();

  @override
  List<Object?> get props => [];
}

final class ShareTextRequested extends ShareEvent {
  const ShareTextRequested({required this.text, this.subject});

  final String text;
  final String? subject;

  @override
  List<Object?> get props => [text, subject];
}

final class ShareUriRequested extends ShareEvent {
  const ShareUriRequested({required this.uri});

  final Uri uri;

  @override
  List<Object?> get props => [uri];
}
