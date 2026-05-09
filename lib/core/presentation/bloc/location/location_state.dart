import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/failure.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoadInProgress extends LocationState {}

final class LocationLoadSuccess extends LocationState {
  const LocationLoadSuccess({
    required this.position,
    this.isTracking = false,
  });

  final GeoPosition position;
  final bool isTracking;

  LocationLoadSuccess copyWith({
    GeoPosition? position,
    bool? isTracking,
  }) {
    return LocationLoadSuccess(
      position: position ?? this.position,
      isTracking: isTracking ?? this.isTracking,
    );
  }

  @override
  List<Object?> get props => [position, isTracking];
}

final class LocationLoadFailure extends LocationState {
  const LocationLoadFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
