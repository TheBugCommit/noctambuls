import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

final class LocationRequested extends LocationEvent {}

final class LocationTrackingStarted extends LocationEvent {}

final class LocationTrackingStopped extends LocationEvent {}

final class LocationPositionUpdated extends LocationEvent {
  const LocationPositionUpdated(this.position);

  final GeoPosition position;

  @override
  List<Object> get props => [position];
}
