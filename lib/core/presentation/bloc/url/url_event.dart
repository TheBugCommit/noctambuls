import 'package:equatable/equatable.dart';

sealed class UrlEvent extends Equatable {
  const UrlEvent();

  @override
  List<Object?> get props => [];
}

final class OpenUrlRequested extends UrlEvent {
  const OpenUrlRequested(this.url);

  final String url;

  @override
  List<Object?> get props => [url];
}

final class OpenMapsUrlRequested extends UrlEvent {
  const OpenMapsUrlRequested({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
