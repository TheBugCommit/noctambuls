import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';

sealed class ObservationFormState extends Equatable {
  const ObservationFormState();

  @override
  List<Object?> get props => [];
}

final class ObservationFormInitial extends ObservationFormState {
  const ObservationFormInitial();
}

final class ObservationFormLoading extends ObservationFormState {
  const ObservationFormLoading();
}

final class ObservationFormReady extends ObservationFormState {
  const ObservationFormReady({
    required this.birds,
    this.geoPosition,
    this.locationError,
    this.isCapturingLocation = false,
  });

  final List<Bird> birds;
  final GeoPosition? geoPosition;
  final LocationErrorType? locationError;
  final bool isCapturingLocation;

  ObservationFormReady copyWith({
    List<Bird>? birds,
    GeoPosition? geoPosition,
    LocationErrorType? locationError,
    bool? isCapturingLocation,
    bool clearError = false,
    bool clearLocation = false,
  }) {
    return ObservationFormReady(
      birds: birds ?? this.birds,
      geoPosition: clearLocation ? null : (geoPosition ?? this.geoPosition),
      locationError: clearError ? null : (locationError ?? this.locationError),
      isCapturingLocation: isCapturingLocation ?? this.isCapturingLocation,
    );
  }

  @override
  List<Object?> get props => [
    birds,
    geoPosition,
    locationError,
    isCapturingLocation,
  ];
}

final class ObservationLocationShowErrorDialog extends ObservationFormState {
  const ObservationLocationShowErrorDialog(this.errorType);

  final LocationErrorType errorType;

  @override
  List<Object?> get props => [errorType];
}

final class ObservationFormSuccess extends ObservationFormState {
  const ObservationFormSuccess();
}

final class ObservationFormError extends ObservationFormState {
  const ObservationFormError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
